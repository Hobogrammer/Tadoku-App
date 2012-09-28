class Round < ActiveRecord::Base
  attr_accessible :book, :fgame, :game, :gmet, :goal, :lang1, :lang2, :lang3, :lyric, :manga, :net, :news, :nico, :pcount, :round_id, :sent, :subs, :user_id

  belongs_to :user

  default_scope order: 'rounds.pcount DESC'
end
