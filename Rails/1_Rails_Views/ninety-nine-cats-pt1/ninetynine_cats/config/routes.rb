Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post :approve, to: 'cat_rental_requests#approve', as: 'approve'
      post :deny, to: 'cat_rental_requests#deny', as: 'deny'
    end
  end
end

# approve_cat_rental_request POST  /cat_rental_requests/:id/approve => cat_rental_requests#approve!
# deny_cat_rental_request POST  /cat_rental_requests/:id/deny => cat_rental_requests#deny!