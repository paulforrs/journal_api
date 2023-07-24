class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    
    def index
        @users = User.all

        render json: {user: @users}
    end

    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
        render json: @user
    end

    def create
        @user = User.new(user_params)

        if @user.save
            @user
        else
            render json: @user.errors, status: :unprocessable_entity
        end
        
        # respond_to do |format|
        #     if @user.save
        #         format.html { redirect_to user_path(@user), notice:"User was successfully created" }
        #         format.json { render :show, status: :created, location: @user}
        #     else
        #         format.html { render :new, status: :unprocessably_entity}
        #         format.json { render json: @user.errors, status: :unprocessable_entity}
        #     end  
        # end
    end

    def edit
    end

    def update
        @user.update(user_params)
    end

    def destroy
        if @user.destroy!
            @user
        else
            render json: {message: "User does not exist"}, status: :bad_request
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def set_user
        @user = User.find(params[:id])
    end
end
