json.user do
    json.(user, :id, :email, :username)
    json.token user.generate_token
end