class MatchesController < ApplicationController
  # GET /match/new
  # GET /match/new.xml
  def new
    @territory = @clan = nil
    @territory = Territory.find params[:territory] if params[:territory]
    @clan = @territory.clan unless @territory.nil?
    respond_to do |format|
      format.html # new.html.erb
      format.js do
        if params[:mode].to_sym == :official
          render :update do |page|
            page << "loc = false;"
            page[:remote_content].replace_html(render :partial => 's2_frame',
                :locals => {
                  :url => 'http://www.savage2clans.com/adm1n/clanmatch.php#map[1]',
                  :viewport_size => [780, 420],
                  :frame_size => [780, 5000],
                  :offset => [0, 0],
                  :extra_onload => "setTimeout(function(){$('frame-container').style.paddingTop='200px'}, 500);console.debug('load')"})
          end
        end
      end
    end
  end
end
