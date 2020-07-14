class CreateOrderdetails < ActiveRecord::Migration[6.0]
	def change
		create_table :orderdetails do |t|
			t.bigint :order_id
			t.bigint :product_id
			t.integer :quantity

			t.timestamps
		end
	end
end
