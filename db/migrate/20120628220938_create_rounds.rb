class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :user_id
      t.integer :round_id
      t.decimal :book
      t.decimal :manga
      t.decimal :net
      t.decimal :fgame
      t.decimal :game
      t.decimal :lyric
      t.decimal :subs
      t.decimal :news
      t.decimal :sent
      t.decimal :nico
      t.decimal :nico
      t.decimal :pcount
      t.integer :goal
      t.boolean :gmet
      t.string :lang1
      t.string :lang2
      t.string :lang3

      t.timestamps
    end
  end
end
