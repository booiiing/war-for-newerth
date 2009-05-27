require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clans/new.html.erb" do
  include ClansHelper
  
  before(:each) do
    assigns[:clan] = stub_model(Clan,
      :new_record? => true,
      :name => "value for name",
      :tag => "value for tag"
    )
  end

  it "renders new clan form" do
    render
    
    response.should have_tag("form[action=?][method=post]", clans_path) do
      with_tag("input#clan_name[name=?]", "clan[name]")
      with_tag("input#clan_tag[name=?]", "clan[tag]")
    end
  end
end


