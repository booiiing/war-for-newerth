require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clans/show.html.erb" do
  include ClansHelper
  before(:each) do
    assigns[:clan] = @clan = stub_model(Clan,
      :name => "value for name",
      :tag => "value for tag"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ tag/)
  end
end

