# == Schema Information
# Schema version: 20090630192501
#
# Table name: matches
#
#  id          :integer         not null, primary key
#  schedule    :datetime
#  attacker_id :integer
#  defender_id :integer
#  winner_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Match do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Match.create!(@valid_attributes)
  end
end
