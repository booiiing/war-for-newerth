# == Schema Information
# Schema version: 20090630192501
#
# Table name: alliances
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Alliance < ActiveRecord::Base
  has_and_belongs_to_many :clans
end
