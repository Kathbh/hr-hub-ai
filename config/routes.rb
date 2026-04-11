Rails.application.routes.draw do
    # get 'employee_portal/show' (automatic)
  devise_for :users
  resource :chat, only: [:show, :create]
  # get 'chat/show'
  # get 'chat/create'
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/employee", to: "employee_portal#show"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # Post Requests from the URL path, send request to AiController, method "chat"
  post "ai/chat", to: "ai#chat"

  namespace :hr do   #d3
    get "dashboard", to: "dashboard#show" #add the missing part
    resources :cases, only: [:index, :show] do
      resources :messages, only: [:create] #add the HR reply route
    end
  end
end
