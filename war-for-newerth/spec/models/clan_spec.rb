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

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Clan do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :tag => "value for tag"
    }
  end

  it "should create a new instance given valid attributes" do
    Clan.create!(@valid_attributes)
  end
end
