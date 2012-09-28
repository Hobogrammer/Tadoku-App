class AddRoundIdToUpdates < ActiveRecord::Migration
  def change
  		add_column :updates, :round_id, :integer
  end
end
