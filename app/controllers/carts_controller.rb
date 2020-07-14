class CartsController < ApplicationController
	before_action :set_cart, only: [:show, :edit, :update, :destroy]
	protect_from_forgery

	# GET /carts
	# GET /carts.json
	def index
		@carts = Cart.all
	end

	# GET /carts/1
	# GET /carts/1.json
	def show
	end

	# GET /carts/new
	def new
		@cart = Cart.new
	end

	# GET /carts/1/edit
	def edit
	end

	# ログイン中のユーザーのカート
	def mycart
		@products=Product.all
		@mycart=Cart.all.where(user_id: session[:user_id])
	end

	# カートに商品を追加する
	# Cartsテーブルに無い場合は追加
	# Cartsテーブルにある場合は個数を追加する(10個を超える場合は10個に制限する)
	def add_to_cart
		uid=params[:cart][:user_id]
		pid=params[:cart][:product_id]
		nq=params[:cart][:quantity].to_i
		old_cart=Cart.find_by(product_id: pid, user_id: uid)

		#foo

		if old_cart != nil
			q=old_cart.quantity.to_i
			if (q+nq) > 10
				q=10
			else
				q=q+nq
			end
			old_cart.update(quantity: q)
		else
			cart=Cart.create(user_id: uid, product_id: pid, quantity: nq)
		end

		redirect_to '/mycart'
	end

	# カートから個数を変更する
	def update_quantity
		# 何らかの処理
		cart=Cart.find_by(id: params[:cart][:cart_id].to_i)
		cart.update(quantity: params[:cart][:quantity].to_i)
		redirect_to '/mycart'
	end

	# ユーザーのカートを空にする
	def clear_cart
		cart=Cart.all.where(user_id: params[:user_id])
		cart.destroy_all

		redirect_to "/mycart"
	end

	# POST /carts
	# POST /carts.json
	def create
		@cart = Cart.new(cart_params)

		respond_to do |format|
			if @cart.save
				format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
				format.json { render :show, status: :created, location: @cart }
			else
				format.html { render :new }
				format.json { render json: @cart.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /carts/1
	# PATCH/PUT /carts/1.json
	def update
		if @cart.update(cart_params)
			redirect_to "/mycart"
		else
			format.html { render :edit }
			format.json { render json: @cart.errors, status: :unprocessable_entity }
		end
	end

	# DELETE /carts/1
	# DELETE /carts/1.json
	def delete
		cart=Cart.find_by(id: params[:cart_id])
		cart.destroy
		redirect_to "/mycart"
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_cart
			@cart = Cart.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def cart_params
			params.require(:cart).permit(:user_id, :product_id, :quantity)
		end
end
