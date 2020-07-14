class AddOldpriceToOrderdetails < ActiveRecord::Migration[6.0]
	def change
		add_column :orderdetails, :old_price, :bigint
	end
end
