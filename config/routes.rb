Rails.application.routes.draw do
  get 'activities/index'
  get 'users/settings'
  devise_for :employees
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/animals", to: "animals#index"
  get "/crops", to: "crops#index"
  get "/admin", to: "admin#index"
  get "/settings", to: "users#settings", as: :settings
  get "/actividad", to: "activities#index", as: :actividad

  # Defines the root path route ("/")
  root 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  resources :locations do
    resources :schedules
    resources :animals
    resources :crops
    resources :employees
  end
end
