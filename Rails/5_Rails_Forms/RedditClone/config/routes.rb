Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  
  resources :subs, except: [:destroy] do 
    member do 
      post 'downvote'
      post 'upvote'
    end
  end

  resources :posts, except: [:index] do 
    resources :comments, only: [:new]
    member do 
      post 'downvote'
      post 'upvote'
    end
  end
  
  resources :comments, only: [:create, :show] do 
    member do 
      post 'downvote'
      post 'upvote'
    end
  end
  root "subs#index"
end
