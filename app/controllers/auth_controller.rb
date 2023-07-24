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
        if @user != nil
            if @user.authenticate(signin_params)
                if @user.token_expired?
                    @user.generate_token
                    render json: @user
                end
                render json: @user
            else
                render json: @user.errors, status: 404
            end
        else
            render json: {message: "invalid credentials"}
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