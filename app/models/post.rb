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
#

class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic

  # lists posts from newest to oldest
  default_scope { order('created_at DESC') }
end
