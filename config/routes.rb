Rails.application.routes.draw do
  root 'projects#index'
  resource :sessions, only: [:new, :create, :destroy]
  resources :projects, except: :show do
    resource :stop, only: [:update, :destroy], module: :projects
  end

  namespace :api do
    scope :v1 do
      resources :projects, only: [:index] do
        resources :tasks, only: [:create, :update, :destroy], shallow: true
      end
      namespace :projects do
        resources :in_progresses, only: [:index]
      end
      resources :todos, only: [:index]
    end
  end
end
