class CreateUsers < ActiveRecord::Migration[6.0]
	def change
		create_table :users do |t|
			t.text :name
			t.text :address
			t.text :mail
			t.integer :age
			t.text :password_digest

			t.timestamps
		end
	end
end
