# == Schema Information
# Schema version: 20090604162055
#
# Table name: clans
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  tag        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Clan < ActiveRecord::Base
  has_many :users
  has_many :territories
  has_and_belongs_to_many :alliances
  
end
