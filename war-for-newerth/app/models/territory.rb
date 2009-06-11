# == Schema Information
# Schema version: 20090611095348
#
# Table name: territories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  map_name   :string(255)
#  shape      :string(255)
#  clan_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  position_x :float
#  position_y :float
#

class Territory < ActiveRecord::Base
  belongs_to :clan
end
