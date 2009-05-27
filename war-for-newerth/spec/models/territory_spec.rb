# == Schema Information
# Schema version: 20090527195153
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
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Territory do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :map_name => "value for map_name",
      :shape => "value for shape",
      :clan_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Territory.create!(@valid_attributes)
  end
end
