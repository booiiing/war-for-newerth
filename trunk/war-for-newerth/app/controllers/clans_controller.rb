class ClansController < ApplicationController
  # GET /clans
  # GET /clans.xml
  def index
    @clans = Clan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clans }
    end
  end

  # GET /clans/1
  # GET /clans/1.xml
  def show
    @clan = Clan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @clan }
    end
  end

  # GET /clans/new
  # GET /clans/new.xml
  def new
    @clan = Clan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @clan }
      format.js do
        url = params[:url]
        url = "http://" + url unless url.start_with? "http://"
        
        clan_name = Clan.get_clan_name(url)
        if clan_name
          render :update do |page|
            page[:clan_img].src = "http://www.savage2clans.com/pubsite/clan_img/#{clan_name}_32.png"
            page[:clan_official_url].value = url
          end
        else
          render :text=>'oh snap!', :status => 418
        end
      end
    end
  end

  # GET /clans/1/edit
  def edit
    @clan = Clan.find(params[:id])
  end

  # POST /clans
  # POST /clans.xml
  def create
    @clan = Clan.new(params[:clan])
    # TODO check if the clan really exists in http://savage2clans.com/
    # TODO add clan manager role for users
    current_user.clan = @clan if current_user.clan.nil? # clan creator should be in a clan
    current_user.save!
    respond_to do |format|
      if @clan.save
        flash[:notice] = 'Clan was successfully created.'
        format.html { redirect_to(@clan) }
        format.xml  { render :xml => @clan, :status => :created, :location => @clan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @clan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clans/1
  # PUT /clans/1.xml
  def update
    @clan = Clan.find(params[:id])
    # TODO prevent unauthorized clan editing
    respond_to do |format|
      if @clan.update_attributes(params[:clan])
        flash[:notice] = 'Clan was successfully updated.'
        format.html { redirect_to(@clan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clans/1
  # DELETE /clans/1.xml
  def destroy
    @clan = Clan.find(params[:id])
    # TODO prevent unauthorized clan removing (admin or clan admin?)
    @clan.destroy if current_user and current_user.clan == @clan

    respond_to do |format|
      format.html { redirect_to(clans_url) }
      format.xml  { head :ok }
    end
  end
end
