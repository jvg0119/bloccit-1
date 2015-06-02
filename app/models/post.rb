# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  topic_id   :integer
#  image      :string
#

class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic
  mount_uploader :image, ImageUploader

  # lists posts from newest to oldest
  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
