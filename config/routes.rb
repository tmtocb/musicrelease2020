Rails.application.routes.draw do
  root 'releases#index'
  post 'releases/search'
  resources :genres
  resources :releases
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
