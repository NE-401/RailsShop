class OrdersController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	protect_from_forgery

	# GET /orders
	# GET /orders.json
	def index
		@orders = Order.all
	end

	# GET /orders/1
	# GET /orders/1.json
	def show
	end

	# GET /orders/new
	def new
		@order = Order.new
	end

	# GET /orders/1/edit
	def edit
	end

	# 注文の確認
	def order_check
		@mycart=Cart.where(user_id: params[:user_id])
		@products=Product.all

		if @mycart == nil
			redirect_to '/products'
		end
	end

	# 注文確定
	def order_confirmed
		# require "date"
		uid=params[:user_id]
		@mycart=Cart.where(user_id: uid)
		order=Order.create(user_id: uid)
		oid=order.id
		@products=Product.all

		@mycart.each do |cart|
			# 商品を指定
			p=@products.find {|v| v[:id] == cart.product_id}
			# 在庫を減らす
			p.update(stock: (p.stock-cart.quantity))
			# 注文明細に登録
			od=Orderdetail.create(order_id: oid,user_id: uid, product_id: cart.product_id,quantity: cart.quantity,old_price: p.price)
		end

		order.save
		@mycart.destroy_all

		@od=Orderdetail.where(order_id: oid)

		render 'order_confirmed'
	end

	def order_history
		if session[:user_id] != nil
			uid=session[:user_id]
		elsif params[:user_id] != nil
			uid=params[:user_id]
		else
			redirect_to "/"
			return
		end
		@products=Product.all
		@order_hist=Orderdetail.where(user_id: uid).order(id: :desc).order(product_id: :asc)

		render 'order_history'
	end

	# POST /orders
	# POST /orders.json
	def create
		@order = Order.new(order_params)

		respond_to do |format|
			if @order.save
				format.html { redirect_to @order, notice: 'Order was successfully created.' }
				format.json { render :show, status: :created, location: @order }
			else
				format.html { render :new }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /orders/1
	# PATCH/PUT /orders/1.json
	def update
		respond_to do |format|
			if @order.update(order_params)
				format.html { redirect_to @order, notice: 'Order was successfully updated.' }
				format.json { render :show, status: :ok, location: @order }
			else
				format.html { render :edit }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /orders/1
	# DELETE /orders/1.json
	def destroy
		@order.destroy
		respond_to do |format|
			format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_order
			@order = Order.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def order_params
			params.require(:order).permit(:user_id, :order_date)
		end
end
