class Post < ActiveRecord::Base
  has_many :comments, dependent: :nullify
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :taggings, dependent: :nullify
  has_many :tags, through: :taggings

  validates :title, presence:true, length: {minimum:7}
  validates :body, presence:true

  def body_snippet
    body.length > 100 ? body[0..99] + "..." : body
  end

  def user_full_name
    user ? user.full_name : "Unknown User"
  end

  def like_for(user)
    likes.find_by_user_id(user)
  end


end
