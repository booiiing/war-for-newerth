require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TerritoriesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "territories", :action => "index").should == "/territories"
    end
  
    it "maps #new" do
      route_for(:controller => "territories", :action => "new").should == "/territories/new"
    end
  
    it "maps #show" do
      route_for(:controller => "territories", :action => "show", :id => "1").should == "/territories/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "territories", :action => "edit", :id => "1").should == "/territories/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "territories", :action => "create").should == {:path => "/territories", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "territories", :action => "update", :id => "1").should == {:path =>"/territories/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "territories", :action => "destroy", :id => "1").should == {:path =>"/territories/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/territories").should == {:controller => "territories", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/territories/new").should == {:controller => "territories", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/territories").should == {:controller => "territories", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/territories/1").should == {:controller => "territories", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/territories/1/edit").should == {:controller => "territories", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/territories/1").should == {:controller => "territories", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/territories/1").should == {:controller => "territories", :action => "destroy", :id => "1"}
    end
  end
end
