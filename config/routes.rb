Rails.application.routes.draw do
  resources :therapists, only: [:create] do
    match 'login', to: 'therapists#login', via: [:post]
    match ':id/patients' to: 'therapists#patients', via: [:post]
  end

  resources :patients, only: [:create] do
    match 'login', to: 'patients#login', via: [:post]
    match ':id/', to: 'patients#show', via: [:post]
    match ':id/update', to: 'patients#update', via: [:post]
    match ':id/delete', to: 'patients#destroy', via: [:post]
    match ':id/data/emotes', to: 'patients#emote', via: [:post]
    match ':id/data/words', to: 'patients#word', via: [:post]
    match ':id/data/medication', to: 'patients#medication', via: [:post]
    match ':id/data/notes', to: 'patients#note', via: [:post]
    match ':id/data/count', to: 'patients#count', via: [:post]
    match ':id/associate', to: 'patients#associate', via: [:post]
    match ':id/unassociate', to: 'patients#unassociate', via: [:post]
    match ':id/therapist', to: 'patients#therapist', via: [:post]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
