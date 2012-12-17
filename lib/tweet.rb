module Tweet

	def self.tweet_up(user, total,client)
		#client.update(".@#{user.name} has #{total} pages recorded and a rank of")
		puts ".@#{user.name} has #{total} pages recorded and a rank of"
	end

	def self.regis_tweet(user,round,client)
		#to add: handle nil langs
		#client.update("@#{user.name}, you are are registered reading #{round.lang}, #{round.lang2}, and #{round.lang3} goal: #{round.goal}.")
		puts "@#{user.name}, you are are registered reading #{round.lang1}, #{round.lang2}, and #{round.lang3} goal: #{round.goal}."
	end

	def self.undo_tweet(user,total,client)
		#client.update(".@#{user.name} has a revised score of #{total} and revised rank of")
		puts ".@#{user.name} has a revised score of #{total} and revised rank of"
	end

	def self.not_regis(user,client)
		#client.update("@#{user}, you are not registered for this round. Please register and try again.")
		puts "@#{user}, you are not registered for this round. Please register and try again."
	end 

	def self.regis_exceed(user,client)
		#client.update("@#{user}, you may only register for 3 languages. Your first three choices will be used.")
		puts "@#{user}, you may only register for 3 languages. Your first three choices will be used."
	end

	def self.already_regis(user,client)
	#	client.update("@#{user}, you are already registered for the current round.")
		puts "@#{user}, you are already registered for the current round."
	end
end