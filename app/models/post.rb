class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, dependent: :destroy, source: :user
    
end
