TadokuApp::Application.routes.draw do
  resources :users
  resources :sessions, only: [:create, :destroy]
  resources :rounds
  resources :updates

  resources :users do
    resources :updates, :rounds
  end
  

  root to: 'view_pages#home'

  match '/manual', to: 'view_pages#manual'
  match '/about', to: 'view_pages#about'
  match '/ranking', to: 'rounds#index'
  
  match '/signin' => redirect("/auth/twitter")
  match '/signout', to: "sessions#destroy", via: :delete

  match "auth/twitter/callback" => "sessions#create"
end

