MintegiMoves::Application.routes.draw do
  root :to => "front/categories#show"

  namespace :front do
    resources :pages, :only => [:show]
    resources :categories, :only => [:show] do
      resources :items, :only => [:show]
    end
  end

  namespace :admin do
    root :to => "items#index"

    match "login" => "admin_user_sessions#new", :as => :login
    match "logout" => "admin_user_sessions#destroy", :as => :logout
    match "forgot_password" => "admin_user_sessions#forgot_password", :as => :forgot_password, :via => :get
    match "forgot_password" => "admin_user_sessions#forgot_password_send_email", :as => :forgot_password, :via => :post
    match "reset_password/:reset_password_code" => "admin_users#reset_password", :as => :reset_password, :via => :get
    match "reset_password/:reset_password_code" => "admin_users#reset_password_submit", :as => :reset_password, :via => :put
    resources :admin_user_sessions, :only => [:new, :create, :destroy]

    resources :log_book_events, :only => [:index]
    resources :admin_users

    resources :categories do
      get :log_book_events, :on => :member
      post :reorder, :on => :collection

      resources :pics, :only => [:index, :create, :destroy] do
        post :reorder, :on => :collection
      end
    end

    resources :items do
      get :log_book_events, :on => :member
      post :reorder, :on => :collection

      resources :pics, :only => [:index, :create, :destroy] do
        post :reorder, :on => :collection
      end
    end
  end
end
