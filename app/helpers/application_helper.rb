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

	def curr_round()
		date = Time.now

		if date.month == 12
			round = (date.year+1).to_s + "01"
		elsif date.month == 1
			round = date.year.to_s + "01"
		elsif date.month.between?(2,5)
			round = date.year.to_s + "02"
		elsif date.month.between?(6,9)
			round = date.year.to_s + "03"			
		end
	end

end
