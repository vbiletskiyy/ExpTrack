Rails.application.routes.draw do
  root to: "dashboard#index"
  resources :users do
    collection do
      get 'login'
      post 'login', to: 'users#perform_login'
      get 'logout'
    end
  end
  resources :spendings
end
