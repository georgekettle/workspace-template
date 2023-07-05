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
      get :transfer
    end
    resources :invitations, only: [:new, :create]
  end
  get '/invitations/:token', to: 'invitations#show', as: :invitation # for accepting workspace invitations
  resources :workspace_users, only: [:destroy, :edit, :update] do
    member do
      patch :make_owner
    end
  end

  root "pages#home"
end
