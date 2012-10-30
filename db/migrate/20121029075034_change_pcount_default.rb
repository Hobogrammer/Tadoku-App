class ChangePcountDefault < ActiveRecord::Migration
	def change
 		change_column :rounds, :pcount, :decimal, default: '0'
 	end
end
