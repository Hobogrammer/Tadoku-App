TadokuApp::Application.routes.draw do
  
  root to: 'view_pages#home'

  match '/manual', to: 'view_pages#manual'
  match '/about', to: 'view_pages#about'
end
