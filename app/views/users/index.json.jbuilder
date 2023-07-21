json.array! @users do |user|
    json.id user.id
    json.email user.email
    json.password user.password
    json.created_at user.created_at
end