Rails.application.routes.draw do
  root 'pages#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users,
                 path: '',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'sign_up'
                 },
                 controllers: {
                   sessions: 'api/v1/sessions',
                   registrations: 'api/v1/registrations',
                   passwords: 'api/v1/passwords'
                 },
                 skip: [:registrations]
                 as :user do
                  post 'sign_up', to: 'api/v1/registrations#create', as: :registration
                  get 'sign_up/new', to: 'api/v1/registrations#new', as: :new_registration
                end

      resources :packages, param: :slug
      resources :reservations, only: [:create, :destroy]
      get 'packages/:package_slug/reservations', to: 'reservations#index'
      delete 'reservations/:id', to: 'reservations#destroy'
    end
  end

  get '*path', to: 'pages#index', via: :all
end
