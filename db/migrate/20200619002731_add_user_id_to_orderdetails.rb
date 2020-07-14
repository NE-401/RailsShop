class AddUserIdToOrderdetails < ActiveRecord::Migration[6.0]
	def change
		add_column :orderdetails, :user_id, :bigint
	end
end
