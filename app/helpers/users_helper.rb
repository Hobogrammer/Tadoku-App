module UsersHelper

	def medium_helper(med)
		case med
		when 'book'
			pg = "page"
		when 'manga'
			pg = "page"
		when 'net'
			pg = "web article"
		when 'fgame'
			pg = "screen"
		when 'game'
			pg = "screen"
		when 'subs'
			pg = "minute"
		when 'news'
			pg = "article"
		when 'sent'
			pg = "sentence"
		when 'nico'
			pg = "minute"
		when 'lyric'
			pg = "lyric"
		end 
	end
end
