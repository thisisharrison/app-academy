Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :feed, only: [:show]
  resource :session, only: [:create, :destroy, :new]
  resources :tweets, only: [:create]
  resources :users, only: [:create, :new, :show] do
    get 'search', on: :collection

    resource :follow, only: [:create, :destroy]
  end

  # jbuilder layout of tweets 
  resources :tweets, only: [:index], defaults: { format: :json }

  root to: redirect('/feed')
end
