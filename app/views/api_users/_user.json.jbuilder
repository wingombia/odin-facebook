json.user do
    json.(user, :id, :email, :username, :picture)
    json.token user.generate_token
end