class Update < ActiveRecord::Migration
  def change

    add_column :posts ,:title, :string
    add_column  :posts, :body, :text
  add_column :comments, :body, :text
  add_column :categories, :title, :string
  add_column :contacts, :email, :string
  add_column :contacts, :name, :string
  add_column :contacts, :subject, :string
  add_column :contacts, :message, :text
end
end
