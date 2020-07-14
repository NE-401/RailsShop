class AddColumnToUsers < ActiveRecord::Migration[6.0]
	def change
		add_column :users, :admin, :boolean, default:true, null:false
		add_column :users, :tel, :text, null:false
	end
end
