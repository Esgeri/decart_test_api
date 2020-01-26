Rails.application.routes.draw do
  resources :currencies, only: [:show, :index]
end
