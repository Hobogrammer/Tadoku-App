module UpdatesHelper

	def start_date_full(round)
		# year = round[0,4].to_i
		# month = round[4,6].to_i
		# day = 01
		# start_date = Date.new(year,month,day)
		start_date = 3.weeks.ago.to_date
	end

	def end_date_full(round)
		# year = round[0,4].to_i
		# month = round[4,6].to_i
		# end_day = Date.civil(year,month,-1)
		# day = end_day.day.to_i
		# end_date = Date.new(year,month,day)
		end_date = Date.tomorrow
	end

	def updates_chart_series(user, round)
		updates_by_day_user = user.updates.where(:round_id => 201204).
												  group("date(created_at)").
												  select("created_at, sum(newread) as total_read")
		(start_date_full("201204")..(Date.today > end_date_full("201204") ? end_date_full("201204") : Date.today)).map do |date|
			update = updates_by_day_user.detect { |update| update.created_at.to_date == date }
			update && update.total_read.to_f || 0
		end.inspect
	end										  
end
