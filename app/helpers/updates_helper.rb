module UpdatesHelper

	def self.start_date_full(round)
		 year = round[0,4].to_i
		 month = round[4,6].to_i
		 case month
		 	when  3,8
		 		day = 15
		 		start_date = Time.new(year,month,day)
		 	else 
		 		day = 01
		 		start_date = Time.new(year,month,day)
		 end
	end

	def self.end_date_full(round)
		 year = round[0,4].to_i
		 month = round[4,6].to_i
		 end_day = Date.civil(year,month,-1)
		 day = end_day.day.to_i
		 end_date = Time.new(year,month,day)
	end

	def updates_chart_series(user, round)
		start_date = UpdatesHelper::start_date_full(round.to_s)
		end_date = UpdatesHelper::end_date_full(round.to_s)
		now = Time.now.in_time_zone("#{user.time_zone}")
		updates_by_day_user = user.updates.where(:round_id => round).group("date(created_at_in_user_time)").select("created_at_in_user_time, sum(newread) as total_read")
		(start_date.to_date..(now.to_date > end_date.to_date ? end_date.to_date  : now.to_date)).map do |date|
			update = updates_by_day_user.detect { |update| 
				update.created_at_in_user_time.to_date == date}
			update && update.total_read.to_f || 0
		end.inspect
	end

	def language_chart_series(user, round, lng)
		start_date = UpdatesHelper::start_date_full(round.to_s)
		end_date = UpdatesHelper::end_date_full(round.to_s)
		now = Time.now.in_time_zone("#{user.time_zone}")
		lang_by_day_user = user.updates.where(:round_id => round, :lang => lng).group("date(created_at_in_user_time)").select("created_at_in_user_time, sum(newread) as total_read")
		(start_date.to_date..(now.to_date > end_date.to_date ? end_date.to_date : now.to_date)).map do |date|
			lang = lang_by_day_user.detect { |lang| lang.created_at_in_user_time.to_date == date }
			lang && lang.total_read.to_f || 0
		end.inspect
	end
end
