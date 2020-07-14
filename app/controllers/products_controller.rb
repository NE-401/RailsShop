class ProductsController < ApplicationController
	# before_action :set_product, only: [:show, :edit, :update, :destroy]
	protect_from_forgery

	@category_list=["その他","書籍","音楽","DVD","ゲーム","PC,周辺機器","キッチン","食品,飲料","ホビー"]
	@msg=""

	# GET /products
	# GET /products.json
	def index
		@products = Product.all
	end

	# 商品一覧ページ
	def products_index
		@products=Product.order(category: :asc).page params[:page]
	end

	def show
	end

	# 商品詳細
	def product_detail
		@product=Product.find_by(id: params[:id])
		@cart=Cart.new
	end

	# 検索
	def search
		search_word=params[:search_word]
		sort_mode=params[:sort_mode]
		category=params[:category]

		if category == "None"
			if sort_mode == "1"
				@products=Product.where(["name like ? or publisher like ?",'%'+search_word+'%','%'+search_word+'%']).order(price: :asc).page params[:page]
			elsif sort_mode == "2"
				@products=Product.where(["name like ? or publisher like ?",'%'+search_word+'%','%'+search_word+'%']).order(price: :desc).page params[:page]
			else
				@products=Product.where(["name like ? or publisher like ?",'%'+search_word+'%','%'+search_word+'%']).offset((page-1)*10).page params[:page]
			end
		else
			if sort_mode == "1"
				@products=Product.where(["category = ? and (name like ? or publisher like ?)",category,'%'+search_word+'%','%'+search_word+'%']).order(price: :asc).page params[:page]
			elsif sort_mode == "2"
				@products=Product.where(["category = ? and (name like ? or publisher like ?)",category,'%'+search_word+'%','%'+search_word+'%']).order(price: :desc).page params[:page]
			else
				@products=Product.where(["category = ? and (name like ? or publisher like ?)",category,'%'+search_word+'%','%'+search_word+'%']).page params[:page]
			end
		end

		render '/products/search'
	end

	# GET /products/new
	def new
		@product = Product.new
	end

	# GET /products/1/edit
	def edit
	end

	# POST /products
	# POST /products.json
	def create
		@product = Product.new(product_params)

		if @product.save
			flash[:notice]="商品を追加しました。"
			redirect_to '/admin'
		else
			flash[:danger]="商品の追加に失敗しました。"
			render 'products/admin_new'
		end
	end

	# PATCH/PUT /products/1
	# PATCH/PUT /products/1.json
	def update
		@product=Product.find_by(id: params[:product][:id])
		if @product.update(product_params)
			redirect_to ('/admin/show/'+params[:product][:id].to_s)
		else
			@product=Product.find_by(id: params[:product][:id])
			render partial: '/products/admin_edit', locals: {product: @product}
		end
	end

	# DELETE /products/1
	# DELETE /products/1.json
	def destroy
		p=Product.find_by(id: params[:id])

		res=p.destroy
		if res==false
			flash[:danger]="既に注文されているため、削除できませんでした。"
		else
			flash[:notice]="削除に成功しました。"
		end
		redirect_to admin_path
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_product
			@product = Product.find_by(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def product_params
			params.require(:product).permit(:name, :publisher, :category, :price, :stock, :image)
		end
end
