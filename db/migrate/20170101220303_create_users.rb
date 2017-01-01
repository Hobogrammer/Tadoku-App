class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :timezone
      t.string :profile_img
      t.boolean :admin

      t.timestamps
    end
  end
end
