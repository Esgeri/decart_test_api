Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  resources :currencies, only: [:show, :index]
end
