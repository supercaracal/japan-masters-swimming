Rails.application.routes.draw do
  root 'application#welcome'

  resources :teams, only: :index do
    resources :swimmers, only: :index do
      resources :results, only: :index
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
