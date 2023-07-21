class ApplicationController < ActionController::API
    def check_auth
        token = request.headers['Authorization'].gsub("Token ", '')
        p Base64.decode64(token)
        if @user = User.find_by_token(token)
            if @user.token_expired?
                @user.generate_token
            end
        else
            render json: {message: "invalid token"}, status: 401
        end         
    end
end
