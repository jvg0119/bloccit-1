class Topic < ActiveRecord::Base
  has_many :posts

  # sets per_page limit for pagination
  self.per_page = 50
end
