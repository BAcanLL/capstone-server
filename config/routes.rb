Rails.application.routes.draw do
  resources :therapists, only: [:create, :update, :destroy] do
  end

  match 'therapists/login', to: 'therapists#login', via: [:post]
  match 'therapists/:id/patients', to: 'therapists#patients', via: [:post]

  resources :patients, only: [:create, :update, :destroy] do
  end

  match 'patients/login', to: 'patients#login', via: [:post]
  match 'patients/:id/', to: 'patients#show', via: [:post]
  match 'patients/:id/update', to: 'patients#update', via: [:post]
  match 'patients/:id/delete', to: 'patients#destroy', via: [:post]
  match 'patients/:id/emotes', to: 'therapists#emote', via: [:post]
  match 'patients/:id/words', to: 'therapists#word', via: [:post]
  match 'patients/:id/medication', to: 'therapists#medication', via: [:post]
  match 'patients/:id/notes', to: 'therapists#note', via: [:post]
  match 'patients/:id/data/emotes', to: 'patients#emote', via: [:post]
  match 'patients/:id/data/words', to: 'patients#word', via: [:post]
  match 'patients/:id/data/words/update', to: 'data#word', via: [:post]
  match 'patients/:id/data/medication', to: 'patients#medication', via: [:post]
  match 'patients/:id/data/notes', to: 'patients#note', via: [:post]
  match 'patients/:id/data/count', to: 'patients#count', via: [:post]
  match 'patients/:id/associate', to: 'patients#associate', via: [:post]
  match 'patients/:id/unassociate', to: 'patients#unassociate', via: [:post]
  match 'patients/:id/therapist', to: 'patients#therapist', via: [:post]
  match 'patients/:id/ecg/store-raw', to: 'data#store_raw', via: [:post]
  match 'patients/:id/ecg/store-data', to: 'data#store_data', via: [:post]
  match 'patients/:id/ecg/raw', to: 'data#ecg_raw', via: [:post]
  match 'patients/:id/ecg/data', to: 'patients#ecg_data', via: [:post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
