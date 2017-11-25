Rails.application.routes.draw do
  # TODO: root は本日のTODOシートにする
  root 'projects#index'
  resource :sessions, only: [:new, :create, :destroy]
  resources :projects, except: :show do
    resource :stop, only: [:update, :destroy], module: :projects
  end

  namespace :api do
    scope :v1 do
      resources :projects, only: [:index] do
        resources :tasks, only: [:create, :update, :destroy], shallow: true do
          resources :pomodoros, only: [:create, :update, :destroy], shallow: true
        end
      end
      namespace :projects do
        resources :in_progresses, only: [:index]
      end
      resources :todos, only: [:index]
    end
  end
end
