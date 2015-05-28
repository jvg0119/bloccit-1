# == Schema Information
#
# Table name: summaries
#
#  id         :integer          not null, primary key
#  body       :text
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Summary < ActiveRecord::Base
  belongs_to :post
end
