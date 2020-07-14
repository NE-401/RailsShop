class ColumnNotNull < ActiveRecord::Migration[6.0]
	def change
		change_column_null :carts, :user_id, false, 0

		change_column_null :carts, :product_id, false, 0

		change_column_null :carts, :quantity, false, 0

		change_column_null :orderdetails, :order_id, false, 0

		change_column_null :orderdetails, :product_id, false, 0

		change_column_null :orderdetails, :quantity, false, 0

		change_column_null :users, :name, false, ""

		change_column_null :users, :tel, false, ""

		change_column_null :users, :address, false, ""

		change_column_null :users, :mail, false, ""

		change_column_null :users, :age, false, 0

		change_column_null :products, :name, false, ""

		change_column_null :products, :publisher, false, ""

		change_column_null :products, :category, false, 0

		change_column_null :products, :price, false, 0

	end
end
