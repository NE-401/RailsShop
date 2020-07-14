class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	protect_from_forgery

	# GET /users
	# GET /users.json
	def index
		@users = User.all
	end

	# GET /users/1
	# GET /users/1.json
	def show
		@user=User.find_by(params[:id])
	end

	# GET /users/new
	def new
		@user = User.new
	end

	# GET /users/1/edit
	def edit
		if session[:user_id] == nil
			redirect_to '/'
		else
			@user=User.find_by(id: session[:user_id])
			render '/users/edit'
		end
	end

	# POST /users
	# POST /users.json
	# ユーザー登録
	def create
		@user = User.new(user_params)

		if @user.save
			render 'register_succeed'
		else
			render "/users/new"
		end
	end

	# PATCH/PUT /users/1
	# PATCH/PUT /users/1.json
	def update
		if @user.update(user_params)
			flash[:notice]="ユーザー情報を変更しました。"
			redirect_to '/mypage'
		else
			render 'users/edit'
		end
	end

	# DELETE /users/1
	# DELETE /users/1.json
	def destroy
		@user.destroy
		respond_to do |format|
			format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_user
			@user = User.find_by(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def user_params
			params.require(:user).permit(:name, :tel, :address, :mail, :age, :password ,:password_confirmation)
		end

		wrap_parameters :user, include: [:mail, :password, :password_confirmation]
end
