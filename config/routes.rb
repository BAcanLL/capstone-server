Rails.application.routes.draw do
  resources :therapists
  resources :patients

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
