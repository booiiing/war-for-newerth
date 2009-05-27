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
