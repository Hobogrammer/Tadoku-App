class Bot < ActiveRecord::Base
include Calc,Tweet, ApplicationHelper

MEDREGEX = /#(books?|manga|net|web|fullgame|fgame|game|news|subs|sentences?|nico|lyric)/i
LANGREGEX = /#(fr|de|es|en|ko|th\b|zh|it|nl|pl|el|ru|eo|sv|he|nn|nb|la|hu|jp|fi|af|ar|be|pt|hr)/i

  def self.main 
    client = Twitter::Client.new
    since = get_id
    puts since
    updates = client.mentions(:since_id=>since)
    updates.reverese!
    updates.each do |update|
    if update.text.scan(/#reg/i)
      if regis_check(update) == false #user in database, not registered for curr_round
        regis(update,client)
      elsif regis_check(update).nil? #user not in database
        puts "Creating new User"
        if update.user.time_zone.nil?
          Tweet::no_tz(update.user.screen_name,client)
        else
          new_user = User.new(uid: update.user.id, name: update.user.screen_name, provider: "twitter", time_zone: update.user.time_zone, avatar: update.user.profile_image_url)
          new_user.save
          bn_usr = User.find_by_uid(update.user.id)
          over_round = bn_usr.rounds.new(:round_id => 1, :pcount => 0)
          over_round.save
          regis(update,client)
        end
      else
        Tweet::already_regis(update.user.name,client)
      end
    elsif !update.text.scan.(MEDREGEX).empty? || !update.text.scan(/#undo/i).empty? || !update.text.scan(/#(target|goal)/i).empty?
      if regis_check(update) != true 
        Tweet::not_regis(update.user.name,client)
      else
        if !update.text.scan(MEDREGEX).empty? 
          split_up = update.text.split(/;/)
          split_up.each do |reup|
             if !reup.scan(MEDREGEX).empty?
               processor(update,reup,client)
             end
          end
          upuser = User.find_by_uid(update.user.id)
          new_total = upuser.rounds.find_by_round_id(ApplicationHelper::curr_round).pcount
          rank = Round::rank(upuser,ApplicationHelper::curr_round)
          Tweet::tweet_up(upuser,new_total.round(2),rank,client)
        elsif update.text.scan(/#(target|goal)/i)
          goal_change(update,client)
        elsif update.text.scan(/#undo/i)
          un_split = update.split(/;/)
          un_split.each do |unup|
            if !unup.scan(/#undo/).empty?
              undo(update,ApplicationHelper::curr_round,client)
            end
          end
        end
      end
    end
    since = update.id
    save_id(since)
  end
end

	def self.processor(update,reup,client)
		usr = User.find_by_uid(update.user.id)
		usr_time = Time.now.in_time_zone("#{usr.time_zone}")
		start_time = UpdatesHelper::start_date_full(ApplicationHelper::curr_round.to_s)
		end_time = UpdatesHelper::end_date_full(ApplicationHelper::curr_round.to_s)
		if usr_time.to_date < start_time.to_date
			Tweet::early_warn(update.user.screen_name,client,start_time)
		elsif usr_time.to_date > end_time.to_date
			Tweet::late_submit(update.user.screen_name,client)			
		else
      		medium = reup.scan(MEDREGEX).first.to_s.gsub(/[^A-Za-z]/, '')
      		language = reup.scan(LANGREGEX).first.to_s.to_s.gsub(/[^A-Za-z]/, '')
      		sub_read = reup.scan(/[.]?\d+/).first.to_f

      		if medium == "sentences" || medium == "sentence"
      			medium = "sent"
      		end

      		medium = "book" if medium =="books"

      		medium = "fgame" if medium == "fullgame"

      		medium = "net" if medium == "web"

      		if language.empty? 
      			usr = User.find_by_uid(update.user.id)
      			language = usr.rounds.find_by_round_id(ApplicationHelper::curr_round).lang1
      		end
      		
      		usrlng = lang_check(update,language)
      		
      		if usrlng == true

      			new_read = Calc::score_calc(sub_read,medium,language).to_f

      			if !reup.scan(/#dr/).empty?
      				new_read = Calc::dr(new_read)
      				sub_Read = Calc::dr(sub_read)
      				dr = true
      			else
      				dr = false
      			end

      			if !reup.scan(/#(second|third|fourth|fifth)/i).empty?
      				reps = repinterp(reup) 
      				new_read = Calc::repeat(new_read,reps)
      				sub_read = Calc::repeat(sub_read,reps)
      			else
      				reps = 0
      			end
      			db_update(update,new_read,medium,language,dr,reps,sub_read,client)
      		else
      			user = update.user.screen_name
      			Tweet::not_regis_lang(user,language,client)
      		end
		end
	end

	def self.regis(update, client)
		puts "User registering"
		requester = update.user.screen_name
		goal = update.text.scan(/[.]?\d+/)
		user = User.find_by_uid(update.user.id)
		user_total = user.rounds.find_by_round_id(1).pcount.to_f
		usr_tier = Tier::tier(user_total)
		new_round = user.rounds.new(round_id: ApplicationHelper::curr_round, goal: goal.first, tier: usr_tier)
		new_round.save
		
		regis_counter = 1

		split_update = update.text.split(/;/)

		split_update.each do |sep_reg|
			if (regis_counter > 3)
				Tweet::regis_exceed(requester,client)
			else
				lang_count = "lang"+ regis_counter.to_s
				if (sep_reg.scan(LANGREGEX).empty? && regis_counter == 1)
					puts "no register language, defaulting to jp"
					regis_lang = "jp"
					user.rounds.find_by_round_id(ApplicationHelper::curr_round).update_attributes(lang_count.to_sym => regis_lang)
				elsif !sep_reg.scan(LANGREGEX).empty?
					regis_lang = sep_reg.scan(LANGREGEX).first.to_s.gsub(/[^A-Za-z]/, '')
					puts "language #{regis_counter}, #{regis_lang}"
					user.rounds.find_by_round_id(ApplicationHelper::curr_round).update_attributes(lang_count.to_sym => regis_lang)

					regis_counter += 1
				end
			end
		end
		puts "Tweeting completed registration"
		usr_round = user.rounds.find_by_round_id(ApplicationHelper::curr_round)
		Tweet::regis_tweet(user,usr_round,client)
	end


	def self.db_update(req,count,med,lang,double,rep,fresh_count,client) #count is the calculated read from the update, fresh_count is the raw, medium read value
		user = User.find_by_uid(req.user.id)
		total = user.rounds.find_by_round_id(ApplicationHelper::curr_round).pcount

		new_total = count.to_f + total.to_f

		usr_tme =  ApplicationHelper::convert_usr_time(user,Time.now)

		new_update = Update.new(:user_id => user.id, :raw => fresh_count ,:newread => count, :medium => med, :lang => lang, :dr => double, :repeat => rep, :round_id => ApplicationHelper::curr_round,:recpage => total, :created_at_in_user_time => usr_tme)
		new_update.save
		ApplicationHelper::medium_update(user,ApplicationHelper::curr_round,med,fresh_count, count,new_total) 
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
			round_check = user.rounds.find_by_round_id(ApplicationHelper::curr_round)
			if round_check.nil?
				return false
			else
				return true
			end
		end
	end

	def self.get_id
		status = File.read("/home/ec2-user/tadoku-app/lib/since_id.txt")
		return status
	end

	def self.save_id(since_id)
		status_file = File.new("/home/ec2-user/tadoku-app/lib/since_id.txt","w")
		status_file.write(since_id)
		status_file.close
	end	

	def self.undo(update,round,client)
		requester_id = update.user.id
		user = User.find_by_uid(requester_id)
		old_total = ApplicationHelper::rollback(user,round)
		if old_total == false
			Tweet::no_undo(user,client)
		else
			rank = Round::rank(user,ApplicationHelper::curr_round)
			Tweet::undo_tweet(user, old_total.round(2),rank,client)
		end
	end

	def self.lang_check(req,lang)
		user = User.find_by_uid(req.user.id)
		round_lang = user.rounds.find_by_round_id(ApplicationHelper::curr_round)
		langarry = [round_lang.lang1, round_lang.lang2, round_lang.lang3]

		langarry.each { |userlang| return true if lang == userlang }
		return false
	end

	def self.goal_change(update,client)
      	new_goal =  update.text.scan(/\d+/).first.to_f
      	round = user.rounds.find_by_round_id(ApplicationHelper::curr_round)
      	if round.nil?
      		Tweet.not_regis(update.user.name,client)
      	else
      		round.goal  = new_goal
      		round.save
      		Tweet.goal_update(user.name,new_goal,client)
      	end
	end

	def self.report(round)
		date = DateTime.now.strftime("%Y_%m_%d")
		file_name = "Tadoku_Report_" + date
		report = File.new("#{file_name}.txt", "w")

		entrants = Round.includes(:user).where(:round_id => round)

		report.puts "<ol>"

		entrants.each do |entrant|
			if entrant.pcount < entrant.goal.to_i && entrant.goal.to_i > 0
				report.puts "<li><span style='color:#99cc00;'>#{entrant.user.name} #{entrant.pcount.round(2)} </span></li>"
			else
				report.puts "<li>#{entrant.user.name} #{entrant.pcount.round(2)}</li>"
			end
		end
		
		report.puts "</ol>"	
		report.puts "\n"

		report.puts "Congratulations to <strong> #{entrants.first.user.name}</strong>"

		report.puts "\n"

		report.puts "<h4>MEDIUM CHAMPS</h4>"
		report.puts "<ul>"

		top_book = Round.includes(:user).where(:round_id => round).reorder('book desc').limit(2)
			report.puts "<li>#{top_book.first.user.name} is our top book reader with #{top_book.first.book.to_f} book pages read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_book.last.user.name} with #{top_book.last.book.to_f} pages recorded.</li>"
			report.puts "</ul>"

		top_manga = Round.includes(:user).where(:round_id => round).reorder('manga desc').limit(2)
			report.puts "<li>#{top_manga.first.user.name} is our top manga reader with #{top_manga.first.manga.to_f} manga pages read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_manga.last.user.name} with #{top_manga.last.manga.to_f} pages recorded.</li>"
			report.puts "</ul>"


		top_net = Round.includes(:user).where(:round_id => round).reorder('net desc').limit(2)
			report.puts "<li>#{top_net.first.user.name} is our top net reader with #{top_net.first.net.to_f} net pages read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_net.last.user.name} with #{top_net.last.net.to_f} pages recorded.</li>"
			report.puts "</ul>"

		top_game = Round.includes(:user).where(:round_id => round).reorder('game desc').limit(2)
			report.puts "<li>#{top_game.first.user.name} is our top game reader with #{top_game.first.game.to_f} game screens read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_game.last.user.name} with #{top_game.last.game.to_f} screens recorded.</li>"
			report.puts "</ul>"

		top_fgame = Round.includes(:user).where(:round_id => round).reorder('fgame desc').limit(2)
			report.puts "<li>#{top_fgame.first.user.name} is our top fgame reader with #{top_fgame.first.fgame.to_f} full game screens read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_fgame.last.user.name} with #{top_fgame.last.fgame.to_f} screens recorded.</li>"
			report.puts "</ul>"

		top_lyric = Round.includes(:user).where(:round_id => round).reorder('lyric desc').limit(2)
			report.puts "<li>#{top_lyric.first.user.name} is our top lyric reader with #{top_lyric.first.lyric.to_f} lyrics read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_lyric.last.user.name} with #{top_lyric.last.lyric.to_f} lyrics recorded.</li>"
			report.puts "</ul>"

		top_subs = Round.includes(:user).where(:round_id => round).reorder('subs desc').limit(2)
			report.puts "<li>#{top_subs.first.user.name} is our top subs reader with #{top_subs.first.subs.to_f} minutes of subs watched.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_subs.last.user.name} with #{top_subs.last.subs.to_f} minutes recorded.</li>"
			report.puts "</ul>"

		top_news = Round.includes(:user).where(:round_id => round).reorder('news desc').limit(2)
			report.puts "<li>#{top_news.first.user.name} is our top news reader with #{top_news.first.news.to_f} news articles read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_news.last.user.name} with #{top_news.last.news.to_f} articles recorded.</li>"
			report.puts "</ul>"

		top_sent = Round.includes(:user).where(:round_id => round).reorder('sent desc').limit(2)
			report.puts "<li>#{top_sent.first.user.name} is our top sent reader with #{top_sent.first.sent.to_f} sentences read.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_sent.last.user.name} with #{top_sent.last.sent.to_f} sentences recorded.</li>"
			report.puts "</ul>"


		top_nico = Round.includes(:user).where(:round_id => round).reorder('nico desc').limit(2)
			report.puts "<li>#{top_nico.first.user.name} is our top nico reader with #{top_nico.first.nico.to_f} nico watched.</li>"
			report.puts "<ul>"
			report.puts "<li>honorable mention goes to #{top_nico.last.user.name} with #{top_nico.last.nico.to_f} nico recorded.</li>"
			report.puts "</ul>"
	

		report.puts "</ul>"
		report.puts "\n"

		lang_list = Update.where(:round_id => round).select(:lang).uniq
		lang_l = lang_list.map(&:lang)
		lang_l.each do |lang|
			lang_top = Hash.new
			report.puts "<h5>  Top 3 #{lang} readers</h5>"
			report.puts "<ol>"
			top_lang_readers = Round.includes(:user).where("round_id = ? and (lang1 = ? or lang2 = ? or lang3 = ?)", round, lang, lang, lang)
			top_lang_readers.each do |top_reader|
				total = 0 
				langups = top_reader.user.updates.where(:round_id => round, :lang => lang).select("sum(newread) as  accum")
				total= langups.map(&:accum)
				total = total[0]
				puts total.class
				lang_top["#{top_reader.user.name}"] = total
			end
			lang_sort = lang_top.sort_by {|k,v| v  || 0}
			lang_sort = lang_sort.reverse
			lang_sort.each do |lang_t|
				report.puts "<li>#{lang_t[0]}  #{lang_t[1]}</li>"
			end
			report.puts "</ol>"
			report.puts "\n"
		end
		report.close
	end
end

