Rails.application.routes.draw do
  resources :categories 
  get '/' => 'sessions#home' 
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new' 
  post '/signup' => 'users#create' 
  delete '/logout' => 'sessions#destroy'
  # get '/most_popular' => 'shops#most_popular' 

  get '/auth/:google_oauth2/callback' => 'sessions#google_omniauth_create'
 
  
  resources :reviews
  resources :shops do
    resources :reviews, only: [:new, :index]
  end

  resources :users, only: [:show]
  # resources :categories
  # resources :shops
  # resources :reviews
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
