Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users

  get '/users/:id', to: 'users#show'
  get '/feed', to: 'users#feed'
  get '/friends', to: 'users#friends'
  get '/users', to: 'users#index'

  root 'books#index'

  resources :books do
      resources :reviews, except: [:show, :index]
  end
  
  get '/about', to: 'about#index'

end
