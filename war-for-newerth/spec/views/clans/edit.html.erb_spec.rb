require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clans/edit.html.erb" do
  include ClansHelper
  
  before(:each) do
    assigns[:clan] = @clan = stub_model(Clan,
      :new_record? => false,
      :name => "value for name",
      :tag => "value for tag"
    )
  end

  it "renders the edit clan form" do
    render
    
    response.should have_tag("form[action=#{clan_path(@clan)}][method=post]") do
      with_tag('input#clan_name[name=?]', "clan[name]")
      with_tag('input#clan_tag[name=?]', "clan[tag]")
    end
  end
end


