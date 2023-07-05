Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
  }
  resources :users, only: [:update]
  resources :workspaces, only: [:show, :update, :new, :create, :destroy] do
    member do
      get :settings
      post :switch
    end
    resources :invitations, only: [:new, :create]
  end
  get '/invitations/:token', to: 'invitations#show', as: :invitation

  root "pages#home"
end
