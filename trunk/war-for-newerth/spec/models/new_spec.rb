# == Schema Information
# Schema version: 20090627162800
#
# Table name: news
#
#  id         :integer         not null, primary key
#  poster_id  :integer
#  title      :string(255)
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe New do
  before(:each) do
    @valid_attributes = {
      :poster_id => 1,
      :text => "value for text"
    }
  end

  it "should create a new instance given valid attributes" do
    New.create!(@valid_attributes)
  end
end
