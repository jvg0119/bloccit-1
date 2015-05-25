class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  # lists posts from newest to oldest
  default_scope { order('created_at DESC') }

  # could have also done it this way
  # scope :ordered_by_title, -> { reorder('posts.title ASC') }
  scope :ordered_by_title, -> { reorder(title: 'ASC') }
  scope :ordered_by_reverse_created_at, -> { reorder(created_at: 'DESC') }
end
