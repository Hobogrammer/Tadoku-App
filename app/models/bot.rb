class Bot < ActiveRecord::Base
include Calc,Tweet, ApplicationHelper

MEDREGEX = /#(books?|manga|net|web|fullgame|fgame|game|news|subs|sentences?|nico|lyric)/i
LANGREGEX = /#(fr|de|es|en|ko|th\b|zh|it|nl|pl|el|ru|eo|sv|he|nn|nb|la|hu|jp|fi|af|ar|be|pt|hr|vi)/i

  def self.main
    client = Update.initialize_twitter
    since = get_id
    puts since
    updates = client.mentions(:since_id=>since)
    updates.reverse!
    updates.each do |update|
    if update.text.scan(/#reg/i)
      if regis_check(update) == false #user in database, not registered for curr_round
        regis(update,client)
      elsif regis_check(update).nil? #user not in database
        puts "Creating new User"
        if update.user.time_zone.nil?
          Tweet.no_tz(update.user.screen_name,client)
        else
          new_user = User.new(uid: update.user.id, name: update.user.screen_name, provider: "twitter", time_zone: update.user.time_zone, avatar: update.user.profile_image_url)
          new_user.save
          bn_usr = User.find_by_uid(update.user.id)
          over_round = bn_usr.rounds.new(:round_id => 1, :pcount => 0)
          over_round.save
          regis(update,client)
        end
      else
        Tweet.already_regis(update.user.name,client)
      end
    elsif !update.text.scan.(MEDREGEX).empty? || !update.text.scan(/#undo/i).empty? || !update.text.scan(/#(target|goal)/i).empty?
      if regis_check(update) != true
        Tweet.not_regis(update.user.name,client)
      else
        if !update.text.scan(MEDREGEX).empty?
          split_up = update.text.split(/;/)
          split_up.each do |reup|
             if !reup.scan(MEDREGEX).empty?
              user_info_update(update)
               processor(update,reup,client)
             end
          end
          upuser = User.find_by_uid(update.user.id)
          new_total = upuser.rounds.find_by_round_id(ApplicationHelper.curr_round).pcount
          rank = Round.rank(upuser,ApplicationHelper.curr_round)
          Tweet.tweet_up(upuser,new_total.round(2),rank,client)
        elsif update.text.scan(/#(target|goal)/i)
          goal_change(update,client)
        elsif update.text.scan(/#undo/i)
          un_split = update.split(/;/)
          un_split.each do |unup|
            if !unup.scan(/#undo/).empty?
              undo(update,ApplicationHelper.curr_round,client)
            end
          end
        end
      end
    end
    since = update.id
    save_id(since)
  end
  true
end

  def self.processor(update,reup,client)
    usr = User.find_by_uid(update.user.id)
    usr_time = Time.now.in_time_zone("#{usr.time_zone}")
    start_time = UpdatesHelper.start_date_full(ApplicationHelper.curr_round.to_s)
    end_time = UpdatesHelper.end_date_full(ApplicationHelper.curr_round.to_s)
    if usr_time.to_date < start_time.to_date
      Tweet.early_warn(update.user.screen_name,client,start_time)
    elsif usr_time.to_date > end_time.to_date
      Tweet.late_submit(update.user.screen_name,client)
    else
          medium = reup.scan(MEDREGEX).first.to_s.gsub(/[^A-Za-z]/, '')
          language = reup.scan(LANGREGEX).first.to_s.to_s.gsub(/[^A-Za-z]/, '')
          sub_read = reup.scan(/[.]?\d+/).first.to_f
          medium = medium_normalizer(medium)

          if language.empty?
            usr = User.find_by_uid(update.user.id)
            language = usr.rounds.find_by_round_id(ApplicationHelper.curr_round).lang1
          end

          usrlng = lang_check(update,language)

          if usrlng == true

            new_read = Calc.score_calc(sub_read,medium,language).to_f

            if !reup.scan(/#dr/).empty?
              new_read = Calc.dr(new_read)
              sub_Read = Calc.dr(sub_read)
              dr = true
            else
              dr = false
            end

            if !reup.scan(/#(second|third|fourth|fifth)/i).empty?
              reps = repinterp(reup)
              new_read = Calc.repeat(new_read,reps)
              sub_read = Calc.repeat(sub_read,reps)
            else
              reps = 0
            end
            db_update(update,new_read,medium,language,dr,reps,sub_read,client)
          else
            user = update.user.screen_name
            Tweet.not_regis_lang(user,language,client)
          end
    end
  end

  def self.regis(update, client)
    puts "User registering"
    requester = update.user.screen_name
    goal = update.text.scan(/[.]?\d+/)
    user = User.find_by_uid(update.user.id)
    user_total = user.rounds.find_by_round_id(1).pcount.to_f
    usr_tier = Tier.tier(user_total)
    new_round = user.rounds.new(round_id: ApplicationHelper.curr_round, goal: goal.first, tier: usr_tier)
    new_round.save

    regis_counter = 1

    split_update = update.text.split(/;/)

    split_update.each do |sep_reg|
      if (regis_counter > 3)
        Tweet.regis_exceed(requester,client)
      else
        lang_count = "lang"+ regis_counter.to_s
        if (sep_reg.scan(LANGREGEX).empty? && regis_counter == 1)
          puts "no register language, defaulting to jp"
          regis_lang = "jp"
          user.rounds.find_by_round_id(ApplicationHelper.curr_round).update_attributes(lang_count.to_sym => regis_lang)
        elsif !sep_reg.scan(LANGREGEX).empty?
          regis_lang = sep_reg.scan(LANGREGEX).first.to_s.gsub(/[^A-Za-z]/, '')
          puts "language #{regis_counter}, #{regis_lang}"
          user.rounds.find_by_round_id(ApplicationHelper.curr_round).update_attributes(lang_count.to_sym => regis_lang)

          regis_counter += 1
        end
      end
    end
    puts "Tweeting completed registration"
    usr_round = user.rounds.find_by_round_id(ApplicationHelper.curr_round)
    Tweet.regis_tweet(user,usr_round,client)
  end


  def self.db_update(req,count,med,lang,double,rep,fresh_count,client) #count is the calculated read from the update, fresh_count is the raw, medium read value
    user = User.find_by_uid(req.user.id)
    total = user.rounds.find_by_round_id(ApplicationHelper.curr_round).pcount

    new_total = count.to_f + total.to_f

    usr_tme =  ApplicationHelper.convert_usr_time(user,Time.now)

    new_update = Update.new(:user_id => user.id, :raw => fresh_count ,:newread => count, :medium => med, :lang => lang, :dr => double, :repeat => rep, :round_id => ApplicationHelper.curr_round,:recpage => total, :created_at_in_user_time => usr_tme)
    new_update.save
    ApplicationHelper.medium_update(user,ApplicationHelper.curr_round,med,fresh_count, count,new_total)
  end

  def self.repinterp(txt)
    if !txt.scan(/#second/).empty?
      repeat_count = 1
    elsif !txt.scan(/#third/).empty?
      repeat_count = 2
    elsif !txt.scan(/#fourth/).empty?
      repeat_count = 3
    else
      repeat_count = 4
    end
  end

  def self.regis_check(update)
    user = User.find_by_uid(update.user.id)
    if user == nil
      return nil
    else
      round_check = user.rounds.find_by_round_id(ApplicationHelper.curr_round)
      if round_check.nil?
        return false
      else
        return true
      end
    end
  end

  def self.get_id
    status = File.read("lib/since_id.txt")
    return status  end

  def self.save_id(since_id)
    status_file = File.new("lib/since_id.txt","w")
    status_file.write(since_id)
    status_file.close
  end

  def self.undo(update,round,client)
    requester_id = update.user.id
    user = User.find_by_uid(requester_id)
    old_total = rollback(user,round)
    if old_total == false
      Tweet.no_undo(user,client)
    else
      rank = Round.rank(user,ApplicationHelper.curr_round)
      Tweet.undo_tweet(user, old_total.round(2),rank,client)
    end
  end

  def self.lang_check(req,lang)
    user = User.find_by_uid(req.user.id)
    round_lang = user.rounds.find_by_round_id(ApplicationHelper.curr_round)
    langarry = [round_lang.lang1, round_lang.lang2, round_lang.lang3]

    langarry.each do |userlang|
      if lang == userlang
        return true
      end
    end
    return false
  end

  def self.goal_change(update,client)
    new_goal =  update.text.scan(/\d+/).first.to_f
    round = user.rounds.find_by_round_id(ApplicationHelper.curr_round)
    if round.nil?
      Tweet.not_regis(update.user.name,client)
    else
      round.goal  = new_goal
      round.save
      Tweet.goal_update(user.name,new_goal,client)
    end
  end

  def self.rollback(user,round)
    del_update = user.updates.where(:round_id => round).last

    if !del_update.present?
       false
    else
      unread = del_update.raw.to_f
      unmed = del_update.medium.to_s
      rev_total = del_update.recpage.to_f
      usr_round = user.rounds.find_by_round_id(round)

      old_read = usr_round.send(unmed).to_f
      rev_read = old_read.to_f - unread.to_f
      usr_round.update_attributes(unmed.to_sym => rev_read)

      usr_round.update_attributes(:pcount => rev_total)
      del_update.destroy

      rev_total
    end
  end

   def self.user_info_update(update)
    usr = User.find_by_uid(update.user.id)
    usr.update_attributes( :name  => update.user.screen_name ) if usr.name != update.user.screen_name
    usr.update_attributes( :avatar => update.user.profile_image_url ) if usr.avatar != update.user.profile_image_url
    usr.update_attributes( :time_zone => update.user.time_zone ) if usr.time_zone != update.user.time_zone
  end

  def self.medium_normalizer(medium)
    if medium == "sentences" || medium == "sentence"
      medium = "sent"
    end

    medium = "book" if medium =="books"

    medium = "fgame" if medium == "fullgame"

    medium = "net" if medium == "web"
  end
end
