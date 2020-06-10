Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "mangopay_users/new", to: "mangopay_users#new", as: "new_mangopay_user" 
  post "mangopay_users", to: "mangopay_users#create" 
end
