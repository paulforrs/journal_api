class RegistrationsController < ApplicationController
    def create
        user = User.create!(
            email: params['user']['email']
            passsword: params['user']['password']
            passsword_confirmation: params['user']['password_confirmation']
        )
        if user
            session[:user_id] = user_id
            render json: {
                status: created,
                user: user
            }
        else
            render jason: {
                status: 500
            }
end