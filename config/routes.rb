Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # resources :companies, only: %w[index new create]
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/team', to: 'pages#team', as: 'team'
  resources :cars, only: %w[index show] do
    resources :reservations, only: %w[create destroy]
  end
  resources :reservations, only: %w[] do
    resources :feedbacks, only: %w[create]
  end
  resources :users, only: [:show]
end
