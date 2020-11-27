Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show] do 
    get :activate, on: :collection
  end

  resource :session, only: [:new, :create, :destroy]
  
  resources :bands do 
    resources :albums, only: [:new]
  end
  
  resources :albums, except: [:new, :index] do 
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new, :index]

  resources :notes, only: [:create, :destroy]

  root to: redirect('/bands')
end

# Notes:
# index, new, create => collection
# show, edit, update, destroy => member

# # Collection Routes:
# index: GET /magazines/:magazine_id/articles
# new: GET /magazines/:magazine_id/articles/new
# create: POST /magazines/:magazine_id/articles

# # Member routes
# show: GET /magazines/:magazine_id/articles/:id
# edit: GET /magazines/:magazine_id/articles/:id/edit
# update: PUT /magazines/:magazine_id/articles/:id
# update: PATCH /magazines/:magazine_id/articles/:id
# destroy: DELETE /magazines/:magazine_id/articles/:id