class Cart < ApplicationRecord
	belongs_to :user, foreign_key: "user_id"
	belongs_to :product, foreign_key: "product_id"

	validates :user_id, presence: true
	validates :product_id, presence: true
	validates :quantity, presence: true
end
