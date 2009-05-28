require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/territories/new.html.erb" do
  include TerritoriesHelper
  
  before(:each) do
    assigns[:territory] = stub_model(Territory,
      :new_record? => true
    )
  end

  it "renders new territory form" do
    render
    
    response.should have_tag("form[action=?][method=post]", territories_path) do
    end
  end
end


