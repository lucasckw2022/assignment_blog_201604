class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user

  has_many :comments
  has_many :tags, :key => :hello
  has_many :likes

  # def title
  #  title.capitalize
  # end

end
