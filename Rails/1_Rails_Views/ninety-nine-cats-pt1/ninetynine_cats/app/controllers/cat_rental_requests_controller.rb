class CatRentalRequestsController < ApplicationController
    def new
        @rental = CatRentalRequest.new
        render :new
    end

    def create
        @rental = CatRentalRequest.new(cat_rental_request_params)

        if @rental.save
            redirect_to cat_url(@rental.cat_id)
        else
            flash.now[:errors] = @rental.errors.full_messages
            render :new
        end
    end

    def approve
        # rental ID is in params! 
        # approve_cat_rental_request_url(rental) => rental is CatRentalRequest obj
        @rental = CatRentalRequest.find_by(id: params[:id])
        
        @rental.approve!
        redirect_to cat_url(@rental.cat_id)
    end

    def deny
        @rental = CatRentalRequest.find_by(id: params[:id])
        
        @rental.deny!
        redirect_to cat_url(@rental.cat_id)
    end

    private
    def cat_rental_request_params
        params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
    end
end
