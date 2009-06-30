# == Schema Information
# Schema version: 20090630192501
#
# Table name: clans
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  tag        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  color      :string(255)
#  image      :binary
#

class Clan < ActiveRecord::Base
  has_many :users
  has_many :territories
  has_and_belongs_to_many :alliances

  validates_presence_of :name
  validates_presence_of :tag
  validates_presence_of :color
  
  validates_length_of :tag, :within => 2..6

  validates_format_of :color, :with => /^#([A-F]|[a-f]|[0-9]){6}$/,
                      :message => 'Color has to be an hex color in #XXXXXX format'

  def color_rgb
    return [0, 0, 0] unless self.color
    return [self.color[1..2].hex, self.color[3..4].hex, self.color[5..6].hex]
  end
end
