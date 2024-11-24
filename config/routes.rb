Rails.application.routes.draw do
  namespace :admin do
      resources :email_verification_tokens
      resources :password_reset_tokens
      resources :sessions
      resources :teams
      resources :team_users
      resources :users

      root to: "email_verification_tokens#index"
    end
  # Authentication routes
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:edit, :create]
    resource :password_reset,     only: [:new, :edit, :create, :update]
  end

  # Solid Queue UI
  mount MissionControl::Jobs::Engine, at: "/admin/jobs"

  # App routes
  resources :lessons, only: :index

  root "pages#home"
end
