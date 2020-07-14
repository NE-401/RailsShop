Rails.application.routes.draw do
	root to: 'home#index'
	get '/index', to: 'home#index'
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	# ログイン
	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy'

	# ユーザー登録
	get '/register', to: 'users#new'
	post '/register', to: 'users#create'

	# 登録完了
	get '/register_succeed', to: 'users#register_succeed'
	post '/register_succeed', to: 'users#register_succeed'

	# マイページ
	get '/mypage', to: 'sessions#mypage'
	post '/mypage', to: 'sessions#mypage'

	# ユーザー情報の編集
	get '/mypage/edit', to: 'users#edit'
	post '/mypage/edit', to: 'users#edit'
	patch '/mypage/edit', to: 'users#update'

	# 商品の検索
	get '/products/search', to: 'products#search'
	post '/products/search', to: 'products#search'

	# 商品一覧
	get '/products', to: 'products#products_index'
	post '/products', to: 'products#products_index'
	get '/products/:page', to: 'products#products_index'
	post '/products/:page', to: 'products#products_index'

	# 商品の詳細
	get '/product_detail/:id', to: 'products#product_detail'

	# カート
	get '/mycart', to: 'carts#mycart'
	post '/mycart', to: 'carts#mycart'
	post '/carts/add_to_cart', to: 'carts#add_to_cart'
	post '/carts/clear_cart', to: 'carts#clear_cart'
	post '/carts/delete', to: 'carts#delete'

	# 個数の変更
	post '/cart/update_quantity', to: 'carts#update_quantity'
	patch '/cart/update_quantity', to: 'carts#update_quantity'

	# 注文の確認
	post '/order_check', to: 'orders#order_check'

	# 注文確定
	post '/order_confirmed', to: 'orders#order_confirmed'

	# 注文履歴
	get '/order_history', to: "orders#order_history"
	post '/order_history', to: "orders#order_history"

	# 管理者用ページ
	get '/admin', to: 'sessions#check'
	get '/admin/new', to: 'sessions#checkadd'
	post '/admin/create', to: 'products#create'
	post '/admin/show', to: 'sessions#checkshow'
	get '/admin/show/:id', to: 'sessions#checkshow'
	post '/admin/edit', to: 'sessions#checkedit'
	post '/admin/destroy', to: 'products#destroy'
	post '/products/edit', to: 'products#edit'
	patch '/products/edit', to: 'products#edit'
	patch '/products/update', to: 'products#update'

	#get 'products', to: 'products#index'
	#post 'products', to: 'products#index'

	#get 'orders', to: 'orders#index'
	#post 'orders', to: 'orders#index'

	#get 'orderdetails', to: 'orderdetails#index'
	#post 'orderdetails', to: 'orderdetails#index'

	#resources :orders
	#resources :products
	#resources :carts
	#resources :users
end
