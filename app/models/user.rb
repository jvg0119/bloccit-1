# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#  avatar                 :string
#  email_favorites        :boolean          default(TRUE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def member?
    role == 'member'
  end

  def favorited(post)
    favorites.where(post_id: post.id).first
  end

  def voted(post)
    votes.where(post_id: post.id).first
  end

  def self.top_rated
    self.select('users.*') # Select all attributes of the user
        .select('COUNT(DISTINCT comments.id) AS comments_count') # Count the comments made by the user
        .select('COUNT(DISTINCT posts.id) AS posts_count') # Count the posts made by the user
        .select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank') # Add the comment count to the post count and label the sum as "rank"
        .joins(:posts) # Ties the posts table to the users table, via the user_id
        .joins(:comments) # Ties the comments table to the users table, via the user_id
        .group('users.id') # Instructs the database to group the results so that each user will be returned in a distinct row
        .order('rank DESC') # Instructs the database to order the results in descending order, by the rank that we created in this query. (rank = comment count + post count)
  end

end
