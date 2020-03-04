json.user do
    json.(user, :username, :picture)
    if signed_in? && current_user != user
        json.befriended !!current_user.friend?(user)
    else
        json.befriended false
    end
end