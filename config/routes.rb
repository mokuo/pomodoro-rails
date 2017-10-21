Rails.application.routes.draw do
  root 'projects#index'
  resources :sessions, only: [:new, :create]
  resources :projects, except: :show do
    resource :stop, only: [:update, :destroy], module: :projects
  end
end
