class TerritoriesController < ApplicationController
@@map_bg = Magick::Image.read('public/images/map.jpg').first

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
    @territories = Territory.find :all

    respond_to do |format|
      format.png do
        canvas = Magick::Image.new(params[:width] || 500, params[:height] || 350,
                      Magick::TextureFill.new(@@map_bg))
        canvas.format = 'png'
        gc = Magick::Draw.new
        @territories.each do |t|
          gc.fill("transparent")
          gc.fill("rgb(#{t.clan.color_rgb.join(',')})") if t.clan
          gc.fill_opacity(0.1);
          gc.stroke('rgb(64, 0, 0)')
          gc.stroke_width(1)
          t.shape.split(',').each{|e| puts e}
          s = t.shape.split(',')
          path = "M #{s[0]} #{s[1]} "
          s[2..-1].each_slice(2) do |p|
            path << "L #{p[0]} #{p[1]} "
          end
          path << "z"
          puts "#{t.name}: #{path}"
          gc.path(path)

#          gc.fill_opacity(1);
          gc.fill("rgb(#{t.clan.color_rgb.join(',')})") if t.clan
          gc.circle(t.position_x, t.position_y, t.position_x + 5, t.position_y)
          gc.draw(canvas)
        end
        send_data canvas.to_blob, :disposition => 'inline',
                                  :type => "image/png"
      end
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
    @territories = Territory.all
    success = true
    shapes = params[:territory][:shape]
    params[:territory][:shape] = params[:territory][:shape][params[:id]]
    success &&= @territory.update_attributes(params[:territory])
    @territories.each do |t|
      success &&= t.update_attribute(:shape, shapes[t.id.to_s])
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
