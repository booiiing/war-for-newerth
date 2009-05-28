require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/territories/show.html.erb" do
  include TerritoriesHelper
  before(:each) do
    assigns[:territory] = @territory = stub_model(Territory)
  end

  it "renders attributes in <p>" do
    render
  end
end

