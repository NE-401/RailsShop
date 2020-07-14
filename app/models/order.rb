class Order < ApplicationRecord
	belongs_to :user, foreign_key: "user_id"
	has_many :orderdetails, foreign_key: "order_id", dependent: :destroy
end
