require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/territories/index.html.erb" do
  include TerritoriesHelper
  
  before(:each) do
    assigns[:territories] = [
      stub_model(Territory),
      stub_model(Territory)
    ]
  end

  it "renders a list of territories" do
    render
  end
end

