class Round < ActiveRecord::Base
  attr_accessible :book, :fgame, :game, :gmet, :goal, :lang1, :lang2, :lang3, :lyric, :manga, :net, :news, :nico, :pcount, :round_id, :sent, :subs, :user_id

  belongs_to :user

  default_scope order: 'rounds.pcount DESC'

  def self.rank(user,roundid)
  		part_list = "SELECT user_id FROM rounds WHERE round_id = :roundid"

  		i = 1

  		part_list.each do |id|
  			if (user.id == id)
  				rank = i
  			end
  			i += 1
  		end
  	end
end
