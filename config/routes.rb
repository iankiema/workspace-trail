Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :packages, param: :slug
      resources :reservations, only: [:create, :destroy]
      get 'packages/:package_slug/reservations', to: 'reservations#index'
      delete 'reservations/:id', to: 'reservations#destroy'
    end
  end

  get '*path', to: 'pages#index', via: :all
end
