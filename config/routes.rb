Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update]
  resources :meals do
    resources :bookings, only: [ :new, :create ]
  end
  get "/my-chef-bookings", to: "bookings#bookings_as_a_chef"
  get "/my-eater-bookings", to: "bookings#bookings_as_an_eater"
  resources :bookings, only: [:destroy]
end

