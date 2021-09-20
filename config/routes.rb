Rails.application.routes.draw do
  resources :reservations, only: [:create, :update]
end
