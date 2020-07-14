class HomeController < ApplicationController
	def index
		@sample=Product.all.sample(3)
	end
end
