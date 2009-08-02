class TerritoriesController < ApplicationController
  # this filter create an updated set of maps when the territories are modified
  after_filter :generate_images, :only => [:update, :destroy]

  @@map_bg = Magick::Image.read('public/images/map.jpg').first

  # GET /territories
  # GET /territories.xml
  def index
    @territories = Territory.all
    # default pagination is 30 items, so this pretty much never will be used
    @news = New.paginate :page => (params[:page] || 1), :order => 'created_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @territories }
    end
  end

  # GET /territories/1
  # GET /territories/1.xml
  def show
    @territory = Territory.find params[:id]

    respond_to do |format|
      format.png do
        # not used anymore
        render :status => 501
      end
      format.html # show.html.erb
      format.xml  { render :xml => @territory }
      format.js { render :partial => "territories/info" }
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
    @territories = Territory.all
    success = true
    shapes = params[:territory][:shape] # all the shapes are saved when a territory changes
    params[:territory][:shape] = params[:territory][:shape][params[:id]] # the shape of the territory we're updating
    success &&= @territory.update_attributes(params[:territory]) # update all attributes of the territory
    @territories.each do |t|
      success &&= t.update_attribute(:shape, shapes[t.id.to_s]) # and the shape of the others
    end
    respond_to do |format|
      if success
        format.html do
          flash[:notice] = 'Territory was successfully updated.'
          redirect_to(@territory)
        end
        format.xml  { head :ok }
        format.js do
          render :update do |page|
            page << notify_msg("The territory was updated!")
            # refresh the territories list
            page['territories-list'].replace_html render(:partial => 'list',
                                                         :locals => {:territories => Territory.find(:all)})
            # re-enable the submit button and change it's title
            page['territory_submit'].enable()
            page['territory_submit'].value = 'Save'
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
          # refresh the list
          page['territories-list'].replace_html render(:partial => 'list',
                                                       :locals => {:territories => Territory.find(:all)})
          # update the map
          page << "delete territories[#{@territory.id}];renderTerritories( $('canvas'), territories );"
        end
      end
    end
  end

  protected

  # Regenerates all the images cached on /public/images/map
  # Should be called after creating, updating or destroying territories.
  def generate_images width=500, height=350
    # Base image with all territories shaded
    canvas = Magick::Image.new(width, height, Magick::TextureFill.new(@@map_bg))
    canvas.format = 'jpg'
    gc = Magick::Draw.new
    Territory.all.each do |t|
      gc.fill("transparent")
      if t.clan
        gc.fill("rgb(#{t.clan.color_rgb.join(',')})")
        gc.fill_opacity(0.25)
      end
      gc.stroke('rgb(64, 0, 0)')
      gc.stroke_width(1)
      if t.shape # uses svg-like shapes
        s = t.shape.split(',')
        path = "M #{s[0]} #{s[1]} "
        s[2..-1].each_slice(2) do |p|
          path << "L #{p[0]} #{p[1]} "
        end
        path << "z"
        gc.path(path)
      end

      if t.clan
        gc.fill("rgb(#{t.clan.color_rgb.join(',')})")
        gc.fill_opacity(1);
      end
      gc.circle(t.position_x, t.position_y, t.position_x + 5, t.position_y)
    end
    gc.draw(canvas)
    canvas.write("#{RAILS_ROOT}/public/images/map/base.jpg"){ self.quality = 95 } # TODO tweak the quality

    true
  end

end
