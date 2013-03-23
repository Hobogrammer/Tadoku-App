class ChangeLangDefaulttoQuotes < ActiveRecord::Migration
  def change
  	change_column :rounds, :lang1, :string, default: ""
  	change_column :rounds, :lang2, :string, default: ""
  	change_column :rounds, :lang3, :string, default: ""
  end
end
