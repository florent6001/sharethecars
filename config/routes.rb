Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :companies
  resources :cars
  resources :reservations do
    resources :feedbacks
  end
end
