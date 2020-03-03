class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :liked_posts, through: :likes, dependent: :destroy, source: :post
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user


  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :username, presence: true, uniqueness: true, allow_blank: false
  after_create :send_mail
  def friend?(user)
    friendships.where(pending: false).find_by(friend_id: user.id) || inverse_friendships.where(pending: false).find_by(user_id: user.id)
  end

  def pending?(user)
    friend = friendships.find_by(friend_id: user.id)
    friend && friend.pending
  end

  def pending_request?
    pending_count = Friendship.where(pending: true).where(friend_id: id).length
    (pending_count > 0) ? pending_count : false
  end

  def get_timeline
    Post.where(user_id: friendships.select(:friend_id)).or(Post.where(user_id: inverse_friendships.select(:user_id))).or(Post.where(user_id: id))
  end

  def generate_token
    payload = { id: id, exp: 60.days.from_now.to_i}
    token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "Should be less than 5MB")
      end
    end
    def send_mail
      UserMailer.welcome(self).deliver_now
    end
end