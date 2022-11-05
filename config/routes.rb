Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  resources :items, only: [:index, :show]
  resources :users, only: [:index, :show]
  resources :categories, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
