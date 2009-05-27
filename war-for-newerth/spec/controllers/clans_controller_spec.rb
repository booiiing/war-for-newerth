require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClansController do

  def mock_clan(stubs={})
    @mock_clan ||= mock_model(Clan, stubs)
  end
  
  describe "GET index" do
    it "assigns all clans as @clans" do
      Clan.stub!(:find).with(:all).and_return([mock_clan])
      get :index
      assigns[:clans].should == [mock_clan]
    end
  end

  describe "GET show" do
    it "assigns the requested clan as @clan" do
      Clan.stub!(:find).with("37").and_return(mock_clan)
      get :show, :id => "37"
      assigns[:clan].should equal(mock_clan)
    end
  end

  describe "GET new" do
    it "assigns a new clan as @clan" do
      Clan.stub!(:new).and_return(mock_clan)
      get :new
      assigns[:clan].should equal(mock_clan)
    end
  end

  describe "GET edit" do
    it "assigns the requested clan as @clan" do
      Clan.stub!(:find).with("37").and_return(mock_clan)
      get :edit, :id => "37"
      assigns[:clan].should equal(mock_clan)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created clan as @clan" do
        Clan.stub!(:new).with({'these' => 'params'}).and_return(mock_clan(:save => true))
        post :create, :clan => {:these => 'params'}
        assigns[:clan].should equal(mock_clan)
      end

      it "redirects to the created clan" do
        Clan.stub!(:new).and_return(mock_clan(:save => true))
        post :create, :clan => {}
        response.should redirect_to(clan_url(mock_clan))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved clan as @clan" do
        Clan.stub!(:new).with({'these' => 'params'}).and_return(mock_clan(:save => false))
        post :create, :clan => {:these => 'params'}
        assigns[:clan].should equal(mock_clan)
      end

      it "re-renders the 'new' template" do
        Clan.stub!(:new).and_return(mock_clan(:save => false))
        post :create, :clan => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested clan" do
        Clan.should_receive(:find).with("37").and_return(mock_clan)
        mock_clan.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :clan => {:these => 'params'}
      end

      it "assigns the requested clan as @clan" do
        Clan.stub!(:find).and_return(mock_clan(:update_attributes => true))
        put :update, :id => "1"
        assigns[:clan].should equal(mock_clan)
      end

      it "redirects to the clan" do
        Clan.stub!(:find).and_return(mock_clan(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(clan_url(mock_clan))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested clan" do
        Clan.should_receive(:find).with("37").and_return(mock_clan)
        mock_clan.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :clan => {:these => 'params'}
      end

      it "assigns the clan as @clan" do
        Clan.stub!(:find).and_return(mock_clan(:update_attributes => false))
        put :update, :id => "1"
        assigns[:clan].should equal(mock_clan)
      end

      it "re-renders the 'edit' template" do
        Clan.stub!(:find).and_return(mock_clan(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested clan" do
      Clan.should_receive(:find).with("37").and_return(mock_clan)
      mock_clan.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the clans list" do
      Clan.stub!(:find).and_return(mock_clan(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(clans_url)
    end
  end

end
