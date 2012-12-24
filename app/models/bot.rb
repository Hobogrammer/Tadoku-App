class Bot < ActiveRecord::Base
include Calc,Tweet, ApplicationHelper

MEDREGEX = /#(books?|manga|net|fullgame|news|subs?|sentences?|nico|undo|lyric|reg)/i
LANGREGEX = /#(fr|de|es|en|ko|th |zh|it|nl|pl|el|ru|eo|sv|he|nn|nb|la|hu|jp|fi|af)/i

	#this got nasty real quick. Now I remember why I seperated the register and the bot
	def self.main 
		client = Twitter::Client.new
		since_id = get_id
		updates = client.mentions(:since_id=> since_id)
		updates.reverse!
		updates.each do |update|
			relevance = update.scan(MEDREGEX)
			if !relevance.empty?
					partaker = update.from_user_name
					reg_check = update.text.scan(/#reg/i)
				reg_check = update.scan(/#reg/i)
				if !reg_check.empty?
					if regis_check(update) == false
						 regis(update,client)
					elsif regis_check(update).nil?
						new_user = User.new(uid: update.from_user_uid, name: update.from_user_name, provider: "twitter")
						new_user.save
						regis(update,client)
					else
						Tweet::already_regis(partaker,client)
					end
				elsif !regis_check(update)  #Check tweeter's registration status if they are not attempting to register
					Tweet::not_regis(partaker,client)
				else
					split_up = update.split(/;/)
					split_up.each do |reup|
						rel_check = reup.text.scan(MEDREGEX)
						if !rel_check.empty?
							processor(update,reup,client)
						end
					end
				end
			end
			since_id = update.id
			save_id(since_id)
		end
	end	


	def self.processor(request,subreq,client)
		unless !subreq.scan(/#undo/i).empty? #this is what happens when you tack on an important fucntion last.
			medium = subreq.scan(MEDREGEX).first.to_s.gsub(/[^A-Za-z]/, '')
			language = subreq.scan(LANGREGEX).first.to_s.to_s.gsub(/[^A-Za-z]/, '')
			sub_read = subreq.scan(/[.]?\d+/).first.to_f

			if language.empty? 
				usr = User.find_by_uid(request.from_user_id)
				language = usr.rounds.find_by_round_id(ApplicationHelper::curr_round).lang1
			end

			new_read = Calc::score_calc(sub_read,medium,language).to_f

			# really wanted to make this a one liner but I need to pass the variable just in case
			if !subreq.scan(/#dr/).empty?
				new_read = Calc::dr(new_read)
				sub_Read = Calc::dr(sub_read)
				dr = true
			else
				dr = false
			end

			if !subreq.scan(/#(second|third|fourth|fifth)/i).empty?
				reps = repinterp(subreq) 
				new_read = Calc::repeat(new_read,reps)
				sub_read = Calc::repeat(sub_read,reps)
			else
				reps = 0
			end
			db_update(request,new_read,medium,language,dr,reps,sub_read,client)
		else
			undo(request,ApplicationHelper::curr_round,client)
		end
	end

	def self.regis(request, client)
		requester = request.from_user_name
		goal = request.text.scan(/[.]?\d+/)
		user = User.find_by_uid(request.from_user_id)
		new_round = user.rounds.new(round_id: ApplicationHelper::curr_round, goal: goal)
		new_round.save

		sep_lang = request.text.split(/;/)
		x = 0

		sep_lang.each do |lang|
			regis_lang = lang.scan(LANGREGEX)

			#adding legacy "default" jp language function
			#this is sort of nasty
			if (sep_lang.count == 0) && regis_lang.empty?
				regis_lang = "jp"
				usr_round = user.rounds.find_by_round_id(ApplicationHelper::curr_round)
				usr_round.update_attributes(:lang1 => regis_lang)
				Tweet::regis_tweet(user, usr_round,client)
			else
				#this is DEFINITELY odd 
				regis_lang = regis_lang.to_s.gsub(/[^A-Za-z0-9_]+/,'')
				if x == 0  
					user.rounds.find_by_round_id(ApplicationHelper::curr_round).update_attributes(:lang1 => regis_lang) #had the idea to make this one loop and just starting x at 1 and writing lang#{x} in the update attributes field
					x += 1
				elsif x == 1
					user.rounds.find_by_round_id(ApplicationHelper::curr_round).update_attributes(:lang2 => regis_lang)
					x += 1
				elsif x == 2
					user.rounds.find_by_round_id(ApplicationHelper::curr_round).update_attributes(:lang3 => regis_lang)
					x += 1
				else
					Tweet::regis_exceed(requester,client)
				end
			end
		end
	end

	def self.db_update(req,count,med,lang,double,rep,fresh_count,client)
		user = User.find_by_uid(req.from_user_id)
		total = user.rounds.find_by_round_id(ApplicationHelper::curr_round).pcount

		new_total = count.to_f + total.to_f

		new_update = Update.new(:user_id => user.id, :raw => fresh_count ,:newread => count, :medium => med, :lang => lang, :dr => double, :repeat => rep, :round_id => ApplicationHelper::curr_round,:recpage => total )
		new_update.save
		ApplicationHelper::medium_update(user,ApplicationHelper::curr_round,med,fresh_count,new_total)
		Tweet::tweet_up(user,new_total,client)
	end

	def self.repinterp(txt)
		if !txt.scan(/#second/).empty?
			repeat_count = 1
		elsif !txt.scan(/#third/).empty?
			repeat_count = 2
		elsif !txt.scan(/#fourth/).empty?
			repeat_count = 3
		else
			repeat_count = 4 #kind of lazy but accounts for unforseen repeat call numbers, could potential be a problem. re-evaluate later
		end	
	end

	def self.regis_check(request)
		user = User.find_by_uid(request.from_user_id)
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
		status_file = File.new("/lib/since_id.txt")
		id = status_file.gets
		status_file.close
	end

	def self.save_id(since_id)
		status_file = File.new("/lib/since_id.txt")
		status_file.write(since_id)
		status_file.close
	end	

	def self.undo(request,round,client)
		requester_id = request.from_user_id
		user = User.find_by_uid(requester_id)
		old_total = ApplicationHelper::rollback(user,round)
		Tweet::undo_tweet(user, old_total,client)
	end
end

