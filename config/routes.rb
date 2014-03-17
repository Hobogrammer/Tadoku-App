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
  get '/ranking', to: 'rounds#index'

  get '/signin' , to: redirect("/auth/twitter")
  get '/signout', to: "sessions#destroy", via: :delete

  get 'rounds/:round_id/:lang', to: "rounds#lang_show", :as => :lang
  get 'rounds/:round_id' , to: 'rounds#show'
  get '/ranking/0' , to: 'rounds#round0_show', :as => :zero
  get 'rounds/:round_id/tier/:tier' , to: 'rounds#tier_show', :as => :tier

  get '/rounds/:round_id/users/:user_id' , to: 'users#old_show', :as => :old_user
  get 'profile/:user_id' , to: 'users#profile'



  get "auth/twitter/callback" , to: "sessions#create"
end

