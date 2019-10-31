Rails.application.routes.draw do

  get 'contacts/index'
  get 'contacts/show'
  get 'contacts/new'
  get 'admin/dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'posts#index'
  
  resources :posts do
    get "search", on: :collection
    resources :likes, only: [:create, :destroy]
  end
  
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]
  resources :comments, only: [:create]
  resources :contacts, only: [:index, :show, :new, :create, :destroy]
  resources :notices, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :posts
  resources :users
end
