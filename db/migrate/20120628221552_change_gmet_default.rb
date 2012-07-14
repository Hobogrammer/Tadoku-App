class ChangeGmetDefault < ActiveRecord::Migration
  def change
  		change_column :rounds, :gmet, :boolean, default: false
  end
end
