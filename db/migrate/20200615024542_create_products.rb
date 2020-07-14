class CreateProducts < ActiveRecord::Migration[6.0]
	def change
		create_table :products do |t|
			t.text :name
			t.text :publisher
			t.integer :category
			t.bigint :price

			t.timestamps
		end
	end
end
