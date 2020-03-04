class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: "User"
    validate :validate_friendship_unique

    private
        def validate_friendship_unique
            if new_record? && friendship_exist?(self)
                errors.add(:friendship, "already exist or pending request")
            end
        end

        def friendship_exist?(friendship)
            Friendship.where(user_id: friend_id, friend_id: user_id).exists? ||
                Friendship.where(user_id: user_id, friend_id: friend_id).exists?
        end
end
