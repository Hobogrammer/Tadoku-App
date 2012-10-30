class AddRepeatAndDrToUpdates < ActiveRecord::Migration
  def change
  		add_column :updates, :repeat, :integer, :default => '1'
  		add_column :updates, :dr, :boolean, :default => false
  end
end
