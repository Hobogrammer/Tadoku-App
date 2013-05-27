module ApplicationHelper
	#Returns the full title on a per-page basis
	def full_title(page_title)
		base_title = "Tadoku Contest Web App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
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
		twitter_url = "http://api.twitter.com/1/users/profile_image?screen_name=#{user.name}&size=original"
		image_tag(twitter_url, alt: user.name, class: "avatar")
	end

	def self.medium_update(user,round,med,newread,new_total)
		usr_round = user.rounds.find_by_round_id(round)
		case med
		when "book"
			old_med = usr_round.book.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:book => new_med , :pcount => new_total)
		when "manga"
			old_med = usr_round.manga.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:manga => new_med , :pcount => new_total)
		when "net"
			old_med = usr_round.net.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:net => new_med , :pcount => new_total)
		when "fgame"
			old_med = usr_round.fgame.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:fgame => new_med , :pcount => new_total)
		when "game"
			old_med = usr_round.game.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:game => new_med , :pcount => new_total)
		when "lyric"
			old_med = usr_round.lyric.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:lyric => new_med , :pcount => new_total)
		when "news"
			old_med = usr_round.news.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:news => new_med , :pcount => new_total)
		when "subs"
			old_med = usr_round.subs.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:subs => new_med , :pcount => new_total)
		when "sent"
			old_med = usr_round.sent.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:sent => new_med , :pcount => new_total)
		when "nico"
			old_med = usr_round.nico.to_f
			new_med = old_med.to_f + newread.to_f
			usr_round.update_attributes(:nico => new_med , :pcount => new_total)
		end
	end

	def self.rollback(user,round)
		del_update = user.updates.where(:round_id => round).last
		if del_update == nil
			return false
		else
			unread = del_update.raw.to_f
			unmed = del_update.medium.to_s
			rev_total = del_update.recpage.to_f
			usr_round = user.rounds.find_by_round_id(round)
			case unmed
			when "book"
				old_read = usr_round.book.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:book => rev_read)				
			when "manga"
				old_read = usr_round.manga.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:manga => rev_read)				
			when "net"
				old_read = usr_round.net.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:net => rev_read)				
			when "fgame"
				old_read = usr_round.fgame.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:fgame => rev_read)
			when "game"
				old_read = usr_round.game.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:game => rev_read)
			when "lyric"
				old_read = usr_round.lyric.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:lyric => rev_read)
			when "subs"
				old_read = usr_round.subs.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:subs => rev_read)
			when "news"
				old_read = usr_round.news.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:news => rev_read)
			when "sent"
				old_read = usr_round.sent.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:sent => rev_read)
			when "nico"
				old_read = usr_round.nico.to_f
				rev_read = old_read.to_f - unread.to_f
				usr_round.update_attributes(:nico => rev_read)
			end
			
			usr_round.update_attributes(:pcount => rev_total)
			del_update.destroy

			return rev_total
		end
	end

	def convert_usr_time(user,orig)
		t_z = user.time_zone
		conv_time = orig.in_time_zone(t_z)
		offset = conv_time.utc_offset
		user_time = orig + offset
		return user_time
	end

	def lang_dist(user,round)
		usr_round = user.rounds.find_by_round_id(round)

		lang_arr = [usr_round.lang1.to_s , usr_round.lang2.to_s, usr_round.lang3.to_s ]
		lang_arr.delete_if { |lang| lang.empty? }

		lang_score = Hash.new

		lang_arr.each do |lang|
			total = 0 
			langups = user.updates..where(:round_id => round, :lang => lang).select("sum(newread) as  accum")
			langups.detect { |langtot| total = langtot.accum }

			lang_score["#{lang}"] = total 
		end

		return lang_score
	end

	def self.prev_rounds
		old_rounds_query = Round.select(:round_id).uniq
		old_rounds = old_rounds_query.map(&:round_id)
	end
end
