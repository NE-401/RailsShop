class AddColumnToProducts < ActiveRecord::Migration[6.0]
	def change
		add_column :products, :stock, :int, default: 0
	end
end
