Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  resources :users
  root 'books#index'

  resources :books do
      resources :reviews, except: [:show, :index]
  end
  
  get '/about', to: 'about#index'

end
