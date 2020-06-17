Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :mangopay do
    get "users/new", to: "users#new"
    post "users", to: "users#create"

    get "pages/new", to: "kycs#new"
    post "pages", to: "kycs#create"

  end 

end
