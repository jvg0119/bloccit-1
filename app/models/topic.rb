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
  has_many :posts

  validates :name, length: { minimum: 5, maximum: 50 }, presence: true
  validates :description, length: { minimum: 10, maximum: 250 }, presence: true
end
