Rails.application.routes.draw do
  devise_for :employees
  devise_for :users

  # Home pública y dashboard privado
  root 'pages#home'
  get 'dashboard', to: 'pages#dashboard'

  # Actividad y Ajustes
  get '/actividad', to: 'activities#index', as: :actividad
  get '/ajustes', to: 'users#settings', as: :ajustes
  get '/settings', to: 'users#settings', as: :settings

  # Admin y crops externos
  get '/crops', to: 'crops#index'
  get '/admin', to: 'admin#index'

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Recursos anidados por location
  resources :locations do
    resources :schedules
    resources :animals
    resources :crops
    resources :employees
  end
end
