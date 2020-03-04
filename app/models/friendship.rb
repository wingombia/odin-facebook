class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: "User"
    validate :validate_friendship_unique

    private
        def validate_friendship_unique
            if Friendship.where(user_id: friend_id, friend_id: user_id).exists? ||
                Friendship.where(user_id: user_id, friend_id: friend_id).exists?
                errors.add(:friendship, "already exist or pending request")
            end
        end
end
