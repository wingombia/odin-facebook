json.post do
    json.poster post.user.username
    json.(post,:content, :created_at, :updated_at) 
    json.likes_count post.likes.count
    json.liked_users post.liked_users.select(:username,:email).as_json(except: [:id])
end