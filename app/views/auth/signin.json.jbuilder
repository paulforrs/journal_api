json.status "success"
json.body do
    json.user do
        json.email @user.email
        json.token @user.token
        json.token_expiration @user.token_expiration
    end
end
