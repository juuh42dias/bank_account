Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'authentications#login'
      resources :users
      post '/accounts/', to: 'account#create'
      post '/accounts/transfer', to: 'account#transfer'
      post '/accounts/deposit', to: 'account#deposit'
      get '/accounts/:account_id/balance', to: 'account#balance', as: :accounts_balance
      get '/accounts', to: 'account#index'
    end
  end
end
