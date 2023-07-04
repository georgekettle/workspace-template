Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
  }
  resources :users, only: [:update]
  resources :workspaces, only: [:show, :new, :create, :destroy] do
    member do
      get :settings
      post :switch
    end
  end

  root "pages#home"
end
