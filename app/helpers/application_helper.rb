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
		# date = Time.now

		# if date.month == 12
		# 	round = (date.year+1).to_s + "01"
		# elsif date.month == 1
		# 	round = date.year.to_s + date.month.to_s
		# elsif date.month.between?(2,5)
		# 	round = date.year.to_s + "05"
		# elsif date.month.between?(6,9) 
		# 	round = date.year.to_s + "09"
		# elsif date.month == 11 #edit this out after this round
		# 	round = date.year.to_s + "04"			
		# end
		round = "201212"
	end

	#TODO: create seperate current round function for 2week rounds. Also add additional button on front page to allow registering for 2week rounds. 

	def twivatar_for(user)
		twitter_url = "http://api.twitter.com/1/users/profile_image?screen_name=#{user.name}&size=original"
		image_tag(twitter_url, alt: user.name, class: "avatar")
	end
end
