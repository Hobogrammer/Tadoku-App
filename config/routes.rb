TadokuApp::Application.routes.draw do
  resources :users
  resources :sessions, only: [:create, :destroy]
  resources :rounds
  resources :updates

  resources :users do
    resources :updates, :rounds
  end


  root to: 'view_pages#home'

  get '/manual', to: 'view_pages#manual'
  get '/about', to: 'view_pages#about'

  get '/signin' , to: redirect("/auth/twitter")
  match '/signout', to: "sessions#destroy", via: :delete

  get 'rounds/:round_id/:lang', to: "rounds#lang_show", :as => :lang
  get 'rounds/:round_id' , to: 'rounds#show'
  get '/ranking/0' , to: 'rounds#round0_show', :as => :zero
  get 'rounds/:round_id/tier/:tier' , to: 'rounds#tier_show', :as => :tier

  get '/rounds/:round_id/users/:user_id' , to: 'users#show', :as => :user_stats
  get 'profile/:user_id' , to: 'users#profile' #users route space is clear. profile may be able to go away

  get "auth/twitter/callback" , to: "sessions#create"
end

