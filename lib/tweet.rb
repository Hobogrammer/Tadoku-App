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
		client.update("@#{user}, '#{lang}' is not one of your registered reading languages. Update skipped. #{random}")
	end
end