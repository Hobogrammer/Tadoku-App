class AddTierToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :tier, :string, default: '0'
  end
end
