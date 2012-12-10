class Bot < ActiveRecord::Base
include Calc,Tweet, ApplicationHelper

MEDREGEX = "/#(books?|manga|net|fullgame|news|subs?|sentences?|nico|undo|lyric)/i"
LANGREGEX = "/#(fr|de|es|en|ko|th |zh|it|nl|pl|el|ru|eo|sv|he|nn|nb|la|hu|jp|fi)/i"

	def self.main 
		client = Twitter::Client.new

	#	since_id = get_id

	#	updates = client.mentions(:since_id=> since_id)
	#	updates.reverse!
	#	updates.each do |update|
			update = "@TadokuBot 53 #book; 26 #manga; buts 2332"
	#		partaker = update.from_user_name
			partaker = "lordsilent"
	#		reg_check = update.text.scan(/#reg/i)
			reg_check = true
			if !reg_check == true
				if reg_check(partaker)
					 reg(partaker)
				else
					not_reg(partaker)
				end
			else
				rel_check = update.text.scan(MEDREGEX)
				if !rel_check.empty?
					split_up = update.text.split(/;/)
					split_up.each do |reup|
						processor(update,reup)
					end
				end
			end
			#since_id = update.id
			#save_id(since_id)
	#	end
	end		

	def processor(request,subreq)
		medium = subreq.scan(MEDREGEX)
		language = subreq.scan(LANGREGEX)
		sub_read = subreq.text.scan(/[.]\d+/)
		new_read = score_calc(sub_read,medium,language)

		if language.empty? 
			#usr = User.find_by_name(subreq.from_user_name)
			usr = "lordsilent"
			language = usr.round.find_by_round_id(curr_round).lang1
		end

		# really wanted to make this a one liner but I need to pass the variable just in case
		if !subreq.text.scan(/#dr/).empty?
			new_read = dr(new_read)
			dr = true
		else
			dr = false
		end

		if !subreq.text.scan(/#repeat/).empty?
			reps = repinterp(subreq.text) 
			new_read = repeat(new_read,reps)
		else
			reps = 0
		end

		dpupdate(request,subreq,new_read,medium,language,dr,reps)
	end

	def reg(request,subreq)
		requester = request.from_user_name
		goal = subreq.text.scan(/[.]?\d+/)
		user = User.new(name: requester, provider: "twitter", uid: request.from_user_id)
		user.rounds.new(round_id: curr_round(), goal: goal)

		sep_lang = request.text.split(/;/)
		x = 0

		sep_lang.each do |lang|
			reg_lang = lang.scan(LANGREGEX)

			#adding legacy "default" jp language function
			#this is sort of nasty
			if (reg_lang.count == 0) && reg_lang.empty?
				reg_lang = "jp"
				user_round = user.rounds.find_by_round_id(curr_round())
				user_round.update_attributes(:lang1 => reg_lang)
				reg_tweet(user, user_round)
			else
				#this is DEFINITELY odd 
				reg_lang = reg_lang.gsub(/[^A-Za-z0-9_]+/,'')
				if x == 0  
					user_round.update_attributes(:lang1 => reg_lang) #had the idea to make this one loop and just starting x at 1 and writing lang#{x} in the update attributes field
				elsif x == 1
					user_round.update_attributes(:lang2 => reg_lang)
				elsif x == 2
					user_round.update_attributes(:lang3 => reg_lang)
				else
					reg_exceed(requester) # you have yet to write this function
				end
			end
		end
	end

	def dbupdate(req,count,med,lang,double,rep)
		user = User.find_by_name(request.from_user_name)
		total = user.rounds.find_by_round_id(curr_round()).pcount

		new_total = count + total


		puts "total for update #{new_total}"

		Update.new(:user_id => user.id, :newread => count, :medium => med, :lang => lang, :dr => double, :repeat => rep, :round_id => curr_round(),:recpage => total )
		user.rounds.find_by_round_id(curr_round()).update_attributes(:pcount => new_total)
	end

	def repinterp(txt)
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

	def reg_check(requester)
		user = User.find_by_name(requester)

		if user == nil
			return false
		else
			return true
		end
	end

	def get_id
		status_file = File.new("/lib/since_id.txt")
		id = status_file.gets
		status_file.close
	end

	def save_id(since_id)
		status_file = File.new("/lib/since_id.txt")
		status_file.write(since_id)
		status_file.close
	end
end