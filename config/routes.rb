Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
  }
  resources :users, only: [:update]
  resources :workspaces, only: [:new, :create, :destroy]

  root "pages#home"
end
