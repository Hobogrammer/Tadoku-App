class AddCreatedAtInUserTimeToUpdates < ActiveRecord::Migration
  def change
  	add_column :updates, :created_at_in_user_time, :timestamp
  end
end
