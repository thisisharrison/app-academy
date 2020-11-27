Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :update, :destroy, :create] do 
    # GET /users/:user_id/artworks
    resources :artworks, only: [:index]
    resources :comments, only: [:index]
    resources :collections, only: [:index]
  end

  resources :artworks, only: [:show, :update, :destroy, :create] do 
    resources :comments, only: [:index]
    member do 
      # member as in /:id links
      # like_artwork POST   /artworks/:id/like
      post :like, to: 'artworks#like', as: 'like'
      # unlike_artwork POST   /artworks/:id/unlike
      post :unlike, to: 'artworks#unlike', as: 'unlike'
      # like_artwork POST   /artworks/:id/favourite
      post :favourite, to: 'artworks#favourite', as: 'favourite'
      # unlike_artwork POST   /artworks/:id/unfavourite
      post :unfavourite, to: 'artworks#unfavourite', as: 'unfavourite'
    end
  end

  resources :artwork_shares, only: [:create, :destroy] do 
    member do 
      # like_artwork POST   /artwork_shares/:id/favourite
      post :favourite, to: 'artwork_shares#favourite', as: 'favourite'
      # unlike_artwork POST   /artwork_shares/:id/unfavourite
      post :unfavourite, to: 'artwork_shares#unfavourite', as: 'unfavourite'
    end
  end

  resources :comments, only: [:create, :destroy] do 
    member do
      # POST   /comments/:id/like
      post :like, to: 'comments#like', as: 'like'
      # POST   /comments/:id/unlike
      post :unlike, to: 'comments#unlike', as: 'unlike'
    end
  end

  resources :collections, only: [:create, :show, :destroy] do
    resources :artworks, only: [:index] do
      # collection_artwork_add POST   /collections/:collection_id/artworks/:artwork_id/add
      post :add, to: 'collections#add_artwork', as: 'add'
      # collection_artwork_remove DELETE /collections/:collection_id/artworks/:artwork_id/remove
      delete :remove, to: 'collections#remove_artwork', as: 'remove'
    end
  end
end
