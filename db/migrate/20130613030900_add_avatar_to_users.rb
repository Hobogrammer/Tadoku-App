class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string, default: ""
  end
end