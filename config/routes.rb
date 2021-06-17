Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
    resources :bookings, only: [ :new, :create, :index, :destroy ]
  end
  resources :meals
end