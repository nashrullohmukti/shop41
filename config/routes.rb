Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :products
  root "home#index"
  resources :products do
    get :who_bought, on: :member
  end
  post "/hook" => "home#hook"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
