# == Schema Information
# Schema version: 20090627162800
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  poster_id  :integer
#  new_id     :integer
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  before(:each) do
    @valid_attributes = {
      :poster_id => 1,
      :new_id => 1,
      :text => "value for text"
    }
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(@valid_attributes)
  end
end
