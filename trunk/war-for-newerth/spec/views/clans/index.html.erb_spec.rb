require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clans/index.html.erb" do
  include ClansHelper
  
  before(:each) do
    assigns[:clans] = [
      stub_model(Clan,
        :name => "value for name",
        :tag => "value for tag"
      ),
      stub_model(Clan,
        :name => "value for name",
        :tag => "value for tag"
      )
    ]
  end

  it "renders a list of clans" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for tag".to_s, 2)
  end
end

