class Updates < ActiveRecord::Base
  attr_accessible :book, :fgame, :game, :lyric, :manga, :news, :nico, :recpcount, :sent, :subs, :user_id

  belongs_to :user
end
