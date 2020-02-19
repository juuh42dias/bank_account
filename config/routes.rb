Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'authentications#login'
      resources :users
    end
  end
end
