class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :nullify
  has_many :tagged_posts, through: :taggings, source: :post

end
