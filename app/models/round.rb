class Round < ActiveRecord::Base
  attr_accessible :book, :fgame, :game, :gmet, :goal, :lang1, :lang2, :lang3, :lyric, :manga, :net, :news, :nico, :pcount, :round_id, :sent, :subs, :user_id
  belongs_to :user

  validates :round_id, presence: true

  default_scope order: 'rounds.pcount DESC'

  def self.rank(user,roundid)
  		part_list = Round.where(:round_id => roundid)

  		i = 1

  		part_list.each do |list|
  			if (user.id == list.user_id)
  		    rank = i
  		    return rank
  			end
  			i += 1
  		end
  	end
end
