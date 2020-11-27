class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def create
        # user = User.new(params.require(:user).permit(:name, :email))
        user = User.new(user_params)
        
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        render json: User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        # user.update or user.update_attributes
        if user.update(user_params)
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: user
    end

    private
    def user_params
        params.require(:user).permit(:name, :email)
    end
end

# Notes:

# UsersController < ApplicationController < ActionController::Base

# ActionController::Base#params = hash of all the paramters available
    # Route parameters (e.g. the :id from /users/:id) = show, delete, update
        # Eg. {"controller":"users","action":"show","id":"2"}
    # Query string (the part of the URL after the ?: ?key=value) = GET
        # Eg. {"admin"=>"true"}
    # POST/PATCH request data (the body of the HTTP request) = POST/PATCH
        # Eg. {"admin":"true","food":"pizza","controller":"users","action":"create"}

# Nesting Parameter
# food[drink][pop]: coke
# {
#     "food": {
#         "carb": "pizza",
#         "no-carb": "salad",
#         "drink": {
#             "pop": "coke"
#         }
#     },
#     "car": "tesla",
#     "controller": "users",
#     "action": "create"
# }
# {"food"=>{"carb"=>"pizza", "no-carb"=>"salad", "drink"=>{"pop"=>"coke"}}, "car"=>"tesla"}

# In postman, user[name] = Terry