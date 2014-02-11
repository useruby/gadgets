Gadgets::Application.routes.draw do
  devise_for :users

  root to: 'home#index'
  get '/gadgets' => 'gadgets#index', as: :user_root

  resources :gadgets
end
