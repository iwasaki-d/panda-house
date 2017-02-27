Rails.application.routes.draw do
  resources :houses, format: false

  root to: 'houses#index'
end
