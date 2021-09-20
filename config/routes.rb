Rails.application.routes.draw do
  resources :healthy, only: [:index]
  resources :reservations, only: [:create]
end
