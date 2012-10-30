class ChangeRepDefaultInUpdates < ActiveRecord::Migration
  def change
  		change_column :updates, :repeat, :integer, default: '0'
  	end
end
