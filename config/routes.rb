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
  get 'send_spendings', to: 'spendings#send_spendings'
  get 'users_list', to: 'spendings#users_list'
  get 'user_spendings/:user_id', to: 'spendings#user_spendings', as: 'user_spendings'
end
