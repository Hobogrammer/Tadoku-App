module Calc

	def score_calc(count,med,lang)
		case med
		when "manga"
			count *=  0.2
		when "game"
			count *= 0.05
		when "fgame"
			count *= (1/6)
		when "net"
			count = count
		when "subs"
			count *= 0.2
		when "sent"
			count = sent_count(count,lang)
		when "nico"
			count *= 0.1
		when "book", "net", "news", "lyric"
			count = count
		end
	end

	def repeat(count,rep)
		count *= (1/(2.0 * rep))
	end

	def dr(count)
		count *= 1.4
	end

	def sent_count(read,la)
		case la 
		when "jp"
			read *= (1/17)
		when "eo"
			read *= (1/23)
		when "en"
			read *= (1/17)
		when "es"
			read *= (1/17)
		when "ko"
			read *= (1/18)
		when "zh"
			read *= (1/25)
		when "de"
			read *= (1/13)
		when "fr"
			read *= (1/16)
		when "it"
			read *= (1/17)
		when "ru"
			read *= (1/24)
		when "nl"
			read *= (1/30)
		else
			read *= (1/33)		
		end
	end

end
