class Product < ApplicationRecord
	has_many :carts, foreign_key: "product_id", dependent: :restrict_with_error
	has_many :orderdetails, foreign_key: "product_id", dependent: :restrict_with_error

	mount_uploader :image, ImageUploader
	validates :name, presence: true
	validates :publisher, presence: true
	validates :price, numericality: true, presence: true
end
