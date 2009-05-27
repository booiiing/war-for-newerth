require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClansController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "clans", :action => "index").should == "/clans"
    end
  
    it "maps #new" do
      route_for(:controller => "clans", :action => "new").should == "/clans/new"
    end
  
    it "maps #show" do
      route_for(:controller => "clans", :action => "show", :id => "1").should == "/clans/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "clans", :action => "edit", :id => "1").should == "/clans/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "clans", :action => "create").should == {:path => "/clans", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "clans", :action => "update", :id => "1").should == {:path =>"/clans/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "clans", :action => "destroy", :id => "1").should == {:path =>"/clans/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/clans").should == {:controller => "clans", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/clans/new").should == {:controller => "clans", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/clans").should == {:controller => "clans", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/clans/1").should == {:controller => "clans", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/clans/1/edit").should == {:controller => "clans", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/clans/1").should == {:controller => "clans", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/clans/1").should == {:controller => "clans", :action => "destroy", :id => "1"}
    end
  end
end
