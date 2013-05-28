class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.string :uid
      t.string :prev_tier
      t.string :curr_tier
      t.boolean :pending
    end
  end
end
