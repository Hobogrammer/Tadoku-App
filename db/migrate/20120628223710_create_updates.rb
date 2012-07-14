class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :user_id
      t.decimal :book
      t.decimal :manga
      t.decimal :fgame
      t.decimal :game
      t.decimal :lyric
      t.decimal :subs
      t.decimal :news
      t.decimal :sent
      t.decimal :nico
      t.decimal :recpcount

      t.timestamps
    end
  end
end
