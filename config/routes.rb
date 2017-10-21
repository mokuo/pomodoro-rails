Rails.application.routes.draw do
  resources :projects, except: :show do
    resource :stop, only: [:update, :destroy], module: :projects
  end
end
