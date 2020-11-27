Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except: [:destroy, :edit, :update] 
  
  resource :session, only: [:new, :create, :destroy]

  resources :goals do 
    member do 
      patch "complete"
    end
    resources :cheers, only: [:create]
  end

  # It's for members of users and goals. 
  # And we'll use commentable_id with polymorph to get users and goals member  
  resources :comments, only: [:create]

  resources :cheers, only: [:index]

  root to: "users#index"
end
