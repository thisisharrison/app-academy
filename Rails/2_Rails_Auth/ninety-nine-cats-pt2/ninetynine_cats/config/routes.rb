Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post :approve
      post :deny
    end
  end

  resources :users, only: [:new, :create]
  # singular resource => we only allow user to have one session at a time
  # only be logged in on one device at a time
  # we don't need a table for session
  # we don't need ID to create and destroy a session
  # new_session GET /session/new sessions#new
  # session     DELETE /session sessions#destroy
  #             POST   /session sessions#create
  resource :session, only: [:new, :create, :destroy]

  root to: redirect('/cats')
end
