class ChangeNewReadAndRecpageToDecimal < ActiveRecord::Migration
	def change
		change_column :updates, :newread, :decimal, default: '0'
		change_column :updates, :recpage, :decimal, default: '0'
	end
end
