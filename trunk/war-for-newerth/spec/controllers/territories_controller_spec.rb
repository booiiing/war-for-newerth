require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TerritoriesController do

  def mock_territory(stubs={})
    @mock_territory ||= mock_model(Territory, stubs)
  end
  
  describe "GET index" do
    it "assigns all territories as @territories" do
      Territory.stub!(:find).with(:all).and_return([mock_territory])
      get :index
      assigns[:territories].should == [mock_territory]
    end
  end

  describe "GET show" do
    it "assigns the requested territory as @territory" do
      Territory.stub!(:find).with("37").and_return(mock_territory)
      get :show, :id => "37"
      assigns[:territory].should equal(mock_territory)
    end
  end

  describe "GET new" do
    it "assigns a new territory as @territory" do
      Territory.stub!(:new).and_return(mock_territory)
      get :new
      assigns[:territory].should equal(mock_territory)
    end
  end

  describe "GET edit" do
    it "assigns the requested territory as @territory" do
      Territory.stub!(:find).with("37").and_return(mock_territory)
      get :edit, :id => "37"
      assigns[:territory].should equal(mock_territory)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created territory as @territory" do
        Territory.stub!(:new).with({'these' => 'params'}).and_return(mock_territory(:save => true))
        post :create, :territory => {:these => 'params'}
        assigns[:territory].should equal(mock_territory)
      end

      it "redirects to the created territory" do
        Territory.stub!(:new).and_return(mock_territory(:save => true))
        post :create, :territory => {}
        response.should redirect_to(territory_url(mock_territory))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved territory as @territory" do
        Territory.stub!(:new).with({'these' => 'params'}).and_return(mock_territory(:save => false))
        post :create, :territory => {:these => 'params'}
        assigns[:territory].should equal(mock_territory)
      end

      it "re-renders the 'new' template" do
        Territory.stub!(:new).and_return(mock_territory(:save => false))
        post :create, :territory => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested territory" do
        Territory.should_receive(:find).with("37").and_return(mock_territory)
        mock_territory.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :territory => {:these => 'params'}
      end

      it "assigns the requested territory as @territory" do
        Territory.stub!(:find).and_return(mock_territory(:update_attributes => true))
        put :update, :id => "1"
        assigns[:territory].should equal(mock_territory)
      end

      it "redirects to the territory" do
        Territory.stub!(:find).and_return(mock_territory(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(territory_url(mock_territory))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested territory" do
        Territory.should_receive(:find).with("37").and_return(mock_territory)
        mock_territory.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :territory => {:these => 'params'}
      end

      it "assigns the territory as @territory" do
        Territory.stub!(:find).and_return(mock_territory(:update_attributes => false))
        put :update, :id => "1"
        assigns[:territory].should equal(mock_territory)
      end

      it "re-renders the 'edit' template" do
        Territory.stub!(:find).and_return(mock_territory(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested territory" do
      Territory.should_receive(:find).with("37").and_return(mock_territory)
      mock_territory.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the territories list" do
      Territory.stub!(:find).and_return(mock_territory(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(territories_url)
    end
  end

end
