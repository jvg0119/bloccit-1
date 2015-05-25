class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  # lists posts from newest to oldest
  default_scope { order('created_at DESC') }
end
