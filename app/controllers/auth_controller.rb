class AuthController < ApplicationController

    def signup
        @user = User.new(signup_params)
        if @user.verify_password(signup_params)
            if @user.save
                @user
            else
                render json: @user.errors, status: 404
            end
        end
    end

    def signin
        @user = User.find_by_email(signin_params[:email])
        p @user.token_expiration
        if @user.authenticate(signin_params)
            @user.generate_token
            render json: @user
        else
            render json: @user.errors, status: 404
        end

    end

    private
    def signup_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def signin_params
        params.require(:user).permit(:email, :password)
    end
end