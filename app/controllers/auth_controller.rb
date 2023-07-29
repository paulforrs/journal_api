class AuthController < ApplicationController

    def signup
        @user = User.new(signup_params)
        if @user.verify_password(signup_params)
            if @user.save
                render :signin
            else
                render json:{
                status: 'failed',
                body: {error: "invalid email and password"}
                }
            end
        else
            render json: {
                status: 'failed',
                body:{
                    error: "password don't match"
                }
            }
        end
    end

    def signin
        begin
            @user = User.find_by_email(signin_params[:email])
            if @user.authenticate(signin_params)
                if @user.token_expired?
                    @user.generate_token
                end
                render :signin
            else
                render json: {
                    status: 'failed',
                    body: "invalid email and password"
                }
            end
        rescue => exception
            render json: {
                status: 'error',
                body:"User doesn't exist"
            }
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