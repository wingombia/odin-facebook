json.user do
    json.(user, :username, :picture)
    if signed_in? && current_user != user
        if current_user.pending?(user)
            json.befriended "pending"
        else
            json.befriended !!current_user.friend?(user)
        end
    else
        json.befriended false
    end
end