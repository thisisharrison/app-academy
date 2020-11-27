class CatRentalRequestsController < ApplicationController
  
  before_action :require_cat_ownership!, only: [:deny, :approve]
  # all these steps require a user 
  before_action :require_user!
  
  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    # @rental_request = CatRentalRequest.new(cat_rental_request_params)
    # Assign current_user as the requester 
    @rental_request = current_user.rental_requests.new(cat_rental_request_params)
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private

  def current_cat_rental_request
    @rental_request ||=
      # CatRentalRequest.includes(:cat).find(params[:id])
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def require_cat_ownership!
    # User method to check if cat's user_id is self.id
      current_user.owns_cat?(current_cat)
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :end_date, :start_date, :status)
  end
end
