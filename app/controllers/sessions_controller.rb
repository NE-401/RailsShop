class SessionsController < ApplicationController
	protect_from_forgery
	def new
	end

	# セッションを生成する
	# ログイン
	def create
		user=User.find_by(mail: params[:session][:mail].downcase)

		if user && user.authenticate(params[:session][:password])
			# 正常にログイン
			view_context.log_in user
			redirect_to '/'
		else
			# エラーメッセージ
			@msg='メールアドレスかパスワードが違います。'
			render 'new'
		end
	end

	# セッションを破棄(ログアウト)
	def destroy
		view_context.log_out
		redirect_to '/'
	end

	# マイページ
	def mypage
		if view_context.logged_in?
			@user=view_context.current_user
			render 'users/mypage'
		else
			redirect_to '/'
		end
	end

	# 管理者ユーザーかチェック
	def check
		@state=true
		if !view_context.logged_in?
			@state=false
		else
			@user=view_context.current_user
		end

		if @user == nil || @user.admin == false
			@state=false
		end

		if @state
			@products=Product.all
		end
	end

	# 管理者かチェック(商品編集ページ用)
	def checkedit
		@state=true
		if !view_context.logged_in?
			@state=false
		else
			@user=view_context.current_user
		end

		if @user == nil || @user.admin == false
			@state=false
		end

		if @state
			@product=Product.find_by(id: params[:id])
		end
	end

	# 管理者かチェック(管理者用商品詳細ページ)
	def checkshow
		checkedit
	end

	def checkadd
		@state=true
		if !view_context.logged_in?
			@state=false
		else
			@user=view_context.current_user
		end

		if @user == nil || @user.admin == false
			@state=false
		end

		if @state
			@product=Product.new
		end
	end
end
