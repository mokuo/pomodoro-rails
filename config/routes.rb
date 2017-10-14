Rails.application.routes.draw do
  resources :projects, except: :show
end
