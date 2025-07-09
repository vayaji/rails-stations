Rails.application.routes.draw do
  devise_for :users, path: 'users', path_names: { sign_up: 'new'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "movies#index"

  resources :movies, only: [:index, :show] do
    get 'reservation', to: 'movies#reservation', as: :reservation

    resources :schedules, only: [] do
      # get 'reservations/new', to: 'reservations#reservation_new', as: :new_reservation
      resources :reservations, only: [:new]
    end
  end
  resources :sheets, only: [:index]
  resources :reservations, only: [:create]

  namespace :admin do
    resources :movies, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :schedules, only: [:new]
    end
    resources :schedules, only: [:index, :create, :edit, :update, :destroy]
    resources :reservations, only: [:index, :new, :create, :show, :update, :destroy]
  end
end
