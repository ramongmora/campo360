Rails.application.routes.draw do
  devise_for :employees
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
  get 'pages#dashboard'
  resources :locations do
    resources :schedules # locations/:id/schedules
    resources :animals # locations/:id/animals
    resources :crops # locations/:id/crops
    resources :employees # locations/:id/employees
  end
end
