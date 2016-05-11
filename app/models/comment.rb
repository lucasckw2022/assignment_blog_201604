class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, presence: {message:"Comments can't be blank"}, uniqueness:true


end
