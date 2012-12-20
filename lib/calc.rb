module Calc

	def self.score_calc(count,med,lang)
		case med
		when "manga"
			count *=  0.2
			return count
		when "game"
			count *= 0.05
			return count
		when "fgame"
			count *= (1/6.0)
			return count
		when "net"
			count = count
		when "sub", "subs"
			count *= 0.2
			return count
		when "sent", "sentences", "sentence"
			count = sent_count(count,lang)
			return count
		when "nico"
			count *= 0.1
			return count
		when "book", "books", "net", "news", "lyric"
			count = count
		end
	end

	def self.repeat(count,rep)
		count *= (1/(2.0 * rep))
	end

	def self.dr(count)
		count *= 1.48
	end

	def self.sent_count(read,la)
		case la 
		when "jp"
			read *= (1/17.0)
		when "eo"
			read *= (1/23.0)
		when "en"
			read *= (1/17.0)
		when "es"
			read *= (1/17.0)
		when "ko"
			read *= (1/18.0)
		when "zh"
			read *= (1/25.0)
		when "de"
			read *= (1/13.0)
		when "fr"
			read *= (1/16.0)
		when "it"
			read *= (1/17.0)
		when "ru"
			read *= (1/24.0)
		when "nl"
			read *= (1/30.0)
		when "af"
			read *= (1/31.0)
		else
			read *= (1/33.0)		
		end
	end
end
