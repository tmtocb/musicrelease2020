Rails.application.routes.draw do
  devise_for :users
  root 'releases#index'
  post 'releases/search'
  resources :genres
  resources :releases do
    member do
      put 'like' => 'releases#like'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
