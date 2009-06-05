class TerritoriesController < ApplicationController
  # GET /territories
  # GET /territories.xml
  def index
    @territories = Territory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @territories }
    end
  end

  # GET /territories/1
  # GET /territories/1.xml
  def show
    @territory = Territory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @territory }
    end
  end

  # GET /territories/new
  # GET /territories/new.xml
  def new
    @territory = Territory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @territory }
    end
  end

  # GET /territories/1/edit
  def edit
    @territories = Territory.find :all
    respond_to { |format| format.html }
  end

  # POST /territories
  # POST /territories.xml
  def create
    @territory = Territory.new(params[:territory])

    respond_to do |format|
      if @territory.save
        format.html do
          flash[:notice] = 'Territory was successfully created.'
          redirect_to(@territory)
        end
        format.xml  { render :xml => @territory, :status => :created, :location => @territory }
        format.js do
          @territories = Territory.find :all;
          render :partial => 'list', :locals => {:territories => @territories}
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @territory.errors, :status => :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /territories/1
  # PUT /territories/1.xml
  def update
    @territory = Territory.find(params[:id])
    
    respond_to do |format|
      if @territory.update_attributes(params[:territory])
        format.html do
          flash[:notice] = 'Territory was successfully updated.'
          redirect_to(@territory)
        end
        format.xml  { head :ok }
        format.js do
          render :update do |page|
            page << notify_msg("The territory was updated!")
            page['territories-list'].replace_html render(:partial => 'list',
                                                         :locals => {:territories => Territory.find(:all)})
          end
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @territory.errors, :status => :unprocessable_entity }
        format.js do
          render :update do |page|
            page << notify_error("The territory could not be updated!");
          end
        end
      end
    end
  end

  # DELETE /territories/1
  # DELETE /territories/1.xml
  def destroy
    @territory = Territory.find(params[:id])
    @territory.destroy

    respond_to do |format|
      format.html { redirect_to(territories_url) }
      format.xml  { head :ok }
      format.js do
        render :update do |page|
          page << notify_msg("Territory deleted!")
          page['territories-list'].replace_html render(:partial => 'list',
                                                       :locals => {:territories => Territory.find(:all)})
          page << "delete territories[#{@territory.id}];renderTerritories( $('canvas'), territories );"
        end
      end
    end
  end
end
