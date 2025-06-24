Rails.application.routes.draw do
  devise_for :employees
  devise_for :users

  # Home y dashboard
  root 'pages#home'
  get '/inicio', to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'

  # Actividad y Ajustes con rutas limpias
  get '/actividad', to: 'activities#index', as: :actividad
  get "activities", to: "activities#index", as: :activities

  get '/ajustes', to: 'users#settings', as: :ajustes

  # Otros recursos
  get '/crops', to: 'crops#index'
  get '/admin', to: 'admin#index'
  get '/settings', to: 'users#settings', as: :settings
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Recursos anidados
  resources :locations do
    resources :schedules
    resources :animals
    resources :crops
    resources :employees
  end
end
