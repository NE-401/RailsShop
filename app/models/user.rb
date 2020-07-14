class User < ApplicationRecord
	has_secure_password

	has_many :carts, foreign_key: "user_id", dependent: :destroy
	has_many :orders, foreign_key: "user_id", dependent: :destroy
	has_many :orderdetails, foreign_key: "user_id", dependent: :destroy

	validates :name, presence: true
	validates :address, presence: true
	validates :mail, mail: {message:"はメールアドレスではありません。"}
	validates :age, numericality: true
	validates :tel, presence: true
	validates :password, length: {in: 8..100}
end
