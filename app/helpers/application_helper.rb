module ApplicationHelper

  def full_title(page_title)
   base_title = "Tadoku Contest Web App"
    if page_title.empty?
     base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def round_name(round)
    year = round[0,4]
    month = Date::MONTHNAMES[round[4,6].to_i]

    round_name = "#{month} #{year}"
  end

  def short_round_name(round)
    year = round[0,4]
    month = Date::ABBR_MONTHNAMES[round[4,6].to_i]

    round_name = "#{month} #{year}"
  end

  def self.curr_round()
    date = Time.now.in_time_zone("Hawaii") #pushed this over to hawaii time so the round doesnt change too soon

    if date.month == 12
      round = (date.year+1).to_s + "01"
    elsif date.month.between?(1,2)
      round = date.year.to_s + "01"
    elsif date.month.between?(3,4)
      round = date.year.to_s + "03"
    elsif date.month.between?(5,7)
      round = date.year.to_s + "06"
    elsif date.month.between?(8,9)
      round = date.year.to_s + "08"
    elsif date.month.between?(10,11)
      round = date.year.to_s + "10"
    end
  end

  def twivatar_for(user)
    twitter_url = user.avatar.gsub("_normal", "")
    image_tag(twitter_url, alt: user.name, class: "avatar")
  end

  def self.medium_update(user,round,med,read_med,newread,new_total)
    usr_round = user.rounds.find_by_round_id(round)
    total_round = user.rounds.find_by_round_id(1)

    old_med = usr_round.send(med).to_f
    new_med = old_med.to_f + read_med.to_f
    new_total_med = new_med + total_round.send(med).to_f
    new_over_total = newread.to_f + total_round.pcount.to_f

    ApplicationHelper.tier_check(user, total_round.pcount.to_f, new_over_total,usr_round)

    usr_round.update_attributes(med.to_sym => new_med, :pcount => new_total)
    total_round.update_attributes(med.to_sym => new_total_med, :pcount => new_over_total)
  end

  def self.tier_check(user, old_total, new_total, usr_round)
    old_tier = Tier.tier(old_total)
    new_tier = Tier.tier(new_total)

    if old_tier != new_tier
      usr_round.update_attributes(:tier => new_tier)
      # TODO: Tweet when promoted
    end
  end

  def self.convert_usr_time(user,orig)
    t_z = user.time_zone
    conv_time = orig.in_time_zone(t_z)
    offset = conv_time.utc_offset
    user_time = orig + offset
  end

  def lang_dist(user,round)
    usr_round = user.rounds.find_by_round_id(round)

    lang_arr = [usr_round.lang1.to_s , usr_round.lang2.to_s, usr_round.lang3.to_s ]
    lang_arr.delete_if { |lang| lang.empty? }

    lang_score = Hash.new

    lang_arr.each do |lang|
    total = 0
    langups = user.updates.where(:round_id => round, :lang => lang).select("sum(newread) as  accum")
    langups.detect { |langtot| total = langtot.accum }

    lang_score["#{lang}"] = total
    end
    lang_score
  end

  def self.prev_rounds
    old_rounds_query = Round.select(:round_id).uniq
    old_rounds = old_rounds_query.map(&:round_id)
  end

  def self.build_update(is_signed_in)
    is_signed_in ? update = current_user.updates.build : nil
  end

  def self.pluralize_sans_count(count, noun, text = nil)
  if count != 0
    count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
  end
end
end
