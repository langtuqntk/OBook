Rails.application.routes.draw do
#TẠM THỜI PHẦN ROUTE HƠI RỐI VÌ EM KHÔNG CHIA CÂY THƯ MỤC RIÊNG CHO ADMIN VÀ USER,
#NẾU CÓ THỜI GIAN EM SẼ CHỈNH LẠI SAU

#  namespace :admin do
#    resources :articles, :comments
#  end

#route StaticPage
  resources :comments
  resources :reviews
  resources :requests
  resources :activities
  resources :categories
  resources :books
  root   'activities#timeline'
  post   '/like_activity', to: 'activities#like_activity'
  delete   '/unlike_activity', to: 'activities#unlike_activity'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
#route StaticPage

  #route account
  get    '/signup',  to: 'users#signup'
  post   '/signup',  to: 'users#do_signup'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'

  get    '/password_forgot',   to: 'password_resets#new'
  post   '/password_forgot',   to: 'password_resets#create'

  delete '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:edit, :update]

#route StaticPage
  #route giao dien nguoi dung
  get    '/profile/:id', to: 'users#profile', as: 'profile'
  get    '/home', to: 'activities#timeline'
  get    '/user_list', to: 'users#user_list'
  get    '/request_list', to: 'requests#request_list'
  get    '/load_content_request/:id', to: 'requests#load_content_request'
  delete    '/remove_request', to: 'requests#remove_request'
  get    '/favorite_list', to: 'books#favorite_list'
  get    '/history_list', to: 'books#history_list'
  get    '/load_content_book/:id', to: 'books#load_content_book'
  delete '/unmark_book/:id', to: 'books#unmark_book'
  get    '/book_list', to: 'books#book_list'
  get    '/search', to: 'books#book_search'

  #book detail route tam thoi cho task static page
  get    '/detail_book/:id', to: 'books#detail_book', :as => 'detail_book'
  get    '/review_list/:book_id', to: 'reviews#load_reviews', :as => 'review_list'
  post   '/comment_list', to: 'comments#load_comments'
  post   '/create_review_book', to: 'books#create_review_book', :as => 'create_review_book'
  get    '/detail_user', to: 'users#detail_user'

  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  #phần route cho giao diện admin
  get    '/admin',    to: 'static_pages#home'
  resources :requests
  resources :categories
  resources :books
#route StaticPage

  #phần route dùng chung
  resources :users do
    member do
      get :following, :followers
    end
  end
end
