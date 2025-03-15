Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy] # Définit une ressource singulière pour la session
  resources :passwords, param: :token
  resources :projects
  resources :tasks
  
  root "pages#home"
  get "dashboard", to: "pages#dashboard"
  get "search", to: "pages#search"
  get "up" => "rails/health#show", as: :rails_health_check
end
