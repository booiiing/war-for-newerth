require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/territories/edit.html.erb" do
  include TerritoriesHelper
  
  before(:each) do
    assigns[:territory] = @territory = stub_model(Territory,
      :new_record? => false
    )
  end

  it "renders the edit territory form" do
    render
    
    response.should have_tag("form[action=#{territory_path(@territory)}][method=post]") do
    end
  end
end


