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

  # Área de soporte
  get 'soporte', to: 'pages#support', as: :support

  # Admin general
  get '/admin', to: 'admin#index'

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Recursos anidados por location
  resources :locations do
    resources :schedules
    resources :animals
    resources :crops
    resources :employees
    resources :transactions, only: %i[index new create]

    # Agrobot IA
    get "agrobot", to: "ai#agrobot", as: :agrobot
    post "agrobot/ask", to: "ai#ask"
  end

  # Rutas independientes para transacciones desde /admin
  resources :transactions, only: %i[edit update destroy]
end
