class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        user = User.all
        render json: user, include: :cart
    end 

    def show 
        user = User.find_by(id: session[:user_id])
        user ? (render json: user) :  (render json: {error: "Not authorized"}, status: :unauthorized)
    end 

    def find_user
        user = User.find(params[:id])
        render json: user
    end 

    def create 
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end 

    private 

    def user_params
        # strong params so that the create user method only gives access to the below information. Note that password_digest gives access to instance methods password and password_confirmation. These methods work because password_digest is a column in our table. 
        params.permit(:username, :password, :password_confirmation, :email_address, :address)
    end 

    def render_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end 

    def render_not_found
        render json: {errors: "User not Found"}, status: :not_found
    end
end
