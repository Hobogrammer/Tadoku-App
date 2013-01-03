class ChangeMediumsDefaultsInRounds < ActiveRecord::Migration
  def change
  		change_column :rounds, :book, :integer, default: '0'
  		change_column :rounds, :manga, :decimal, default: '0'
  		change_column :rounds, :net, :decimal, default: '0'
  		change_column :rounds, :fgame, :decimal, default: '0'
  		change_column :rounds, :game, :decimal, default: '0'
  		change_column :rounds, :subs, :decimal, default: '0'
  		change_column :rounds, :lyric, :decimal, default: '0'
  		change_column :rounds, :sent, :decimal, default: '0'
  		change_column :rounds, :nico, :decimal, default: '0'
  		change_column :rounds, :news, :decimal, default: '0'
  end
end
