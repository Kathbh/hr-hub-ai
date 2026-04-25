Rails.application.routes.draw do
  devise_for :users

  # Teams (global)
  resources :messages, only: [:create]

  # Home
  root to: "pages#home"

  # Employee home (dashboard del empleado)
  get "/employee", to: "employee_portal/employee_portal#show"


  # Chat IA del empleado (EmployeePortal::ChatsController)
  namespace :employee_portal do
    post "ai/ask", to: "ai#ask"
    
    resource :chat, only: [:show, :create]
    resources :policies, only: [:show]
    resources :cases, only: [:index, :show] do
      resources :messages, only: [:create]
    end

    resources :messages, only: [:create]
  end

  # HR Portal
  namespace :hr do
    get "dashboard", to: "dashboard#show"

    resources :cases, only: [:index, :show] do
      patch :update_status, on: :member
      resources :messages, only: [:create]
    end

    resources :policies, only: [:show]
  end

  # Global policies (si las usas fuera del portal)
  resources :policies, only: [:show]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
