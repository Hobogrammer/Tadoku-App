class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :user_id
      t.integer :round_id
      t.integer :newread
      t.string :medium
      t.string :lang
      t.integer :recpage

      t.timestamps
    end
  end
end
