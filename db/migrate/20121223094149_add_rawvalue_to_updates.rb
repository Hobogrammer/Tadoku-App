class AddRawvalueToUpdates < ActiveRecord::Migration
  def change
  		add_column :updates, :raw, :decimal, default: '0'
  end
end
