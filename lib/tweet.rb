module Tweet

	$random = rand(1000)

	def self.tweet_up(user,total,rank,client)
		client.update(".@#{user.name} has #{total} pages recorded and a rank of #{rank}.")
		#puts ".@#{user.name} has #{total} pages recorded and a rank of #{rank}."
	rescue 
		client.update(".@#{user.name} has #{total} pages recorded and a rank of #{rank}. #{$random}")
	end

	def self.regis_tweet(user,round,client)
		client.update("@#{user.name}, you are registered reading #{round.lang1.to_s} #{round.lang2.to_s} #{round.lang3.to_s} goal: #{round.goal.to_s}.")
		#puts "@#{user.name}, you are registered reading #{round.lang1.to_s}, #{round.lang2.to_s}, and #{round.lang3.to_s} goal: #{round.goal.to_s}."
	rescue
		client.update("@#{user.name}, you are registered reading #{round.lang1.to_s}, #{round.lang2.to_s}, and #{round.lang3.to_s} goal: #{round.goal.to_s}. #{$random}")
	end

	def self.undo_tweet(user,total,rank,client)
		client.update(".@#{user.name} has a revised score of #{total} and revised rank of #{rank}.")
		#puts ".@#{user.name} has a revised score of #{total} and revised rank of #{rank}."
	rescue
		client.update(".@#{user.name} has a revised score of #{total} and revised rank of #{rank}. #{$random}")
	end

	def self.not_regis(user,client)
		client.update("@#{user}, you are not registered for this round. Please register and try again.")
		#puts "@#{user}, you are not registered for this round. Please register and try again."
	rescue
		client.update("@#{user}, you are not registered for this round. Please register and try again. #{$random}")
	end 

	def self.regis_exceed(user,client)
		client.update("@#{user}, you may only register for 3 languages. Your first three choices will be used.")
		#puts "@#{user}, you may only register for 3 languages. Your first three choices will be used."
	rescue
		client.update("@#{user}, you may only register for 3 languages. Your first three choices will be used. #{$random}")
	end

	def self.already_regis(user,client)
		client.update("@#{user}, you are already registered for the current round.")
		#puts "@#{user}, you are already registered for the current round."
	rescue
		client.update("@#{user}, you are already registered for the current round. #{$random}")
	end

	def self.not_regis_lang(user,lang,client)
		client.update("@#{user}, '#{lang}' is not one of your registered reading languages. Update skipped.")
		#puts "@#{user}, '#{lang}' is not one of your registered reading languages. Update skipped."
	rescue
		client.update("@#{user}, '#{lang}' is not one of your registered reading languages. Update skipped. #{$random}")
	end

	def self.goal_update(user,goal,client)
		client.update("@#{user}, your goal has been updated to #{goal} pages.")
		#puts "@#{user}, your goal has been updated to #{goal} pages."
	rescue
		client.update("@#{user}, your goal has been updated to #{goal} pages. #{$random}")
	end

	def self.no_undo(user,client)
		client.update("@#{user.name}, you do not have any updates to undo.")
		#puts "@#{user}, you do not have any updates to undo."
	rescue
		client.update("@#{user.name}, you do not have any updates to undo.  #{$random}")
	end

	def self.no_tz(user,client)
		client.update("@#{user}, please set the timezone in your account settings and try again.")
		#puts "@#{user}, please set the timezone in your account settings and try again."
	rescue
		client.update("@#{user}, please set the timezone in your account settings and try again. #{$random}")
	end

	def self.early_warn(user,client,start_time)
		client.update("@#{user}, you're too early. Contest starts #{start_time.to_date} 00:00:00 your time.")
		#puts "@#{user}, you're too early. Contest starts #{start_time.to_date} 00:00:00 your time."
	rescue
		client.update("@#{user}, you're too early. Contest starts #{start_time.to_date} 00:00:00 your time. #{$random}")
	end

	def self.late_submit(user,client)
		client.update("@#{user}, sorry, the contest has already ended in your timezone")
		#puts "@#{user}, sorry, the contest has already ended in your timezone"
	rescue
		client.update("@#{user}, sorry, the contest has already ended in your timezone. #{$random}")
	end
end