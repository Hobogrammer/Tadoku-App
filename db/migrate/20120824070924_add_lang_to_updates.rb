class AddLangToUpdates < ActiveRecord::Migration
  def change
  		add_column :updates, :lang, :string
  end
end
