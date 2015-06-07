# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  name        :string
#  public      :boolean          default(TRUE)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  scope :publicly_viewable, -> { where(public: true) }
  scope :privately_viewable, -> { where(public: false) }

  scope :visible_to, -> (user) { user ? all : publicly_viewable }
end
