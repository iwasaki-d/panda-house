Rails.application.routes.draw do
  resources :houses

  root to: 'houses#index'
end
