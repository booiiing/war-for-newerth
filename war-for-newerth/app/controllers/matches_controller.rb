class MatchesController < ApplicationController
  # GET /match/new
  # GET /match/new.xml
  def new
    @territory = Territory.find params[:territory] if params[:territory]
    respond_to do |format|
      format.html # new.html.erb
      format.js do
        if params[:mode].to_sym == :official
          render :update do |page|
            page.loc = false
            page[:remote_content].replace_html(render :partial => 's2_frame',
                :locals => {
                  :url => 'http://www.savage2clans.com/adm1n/clanmatch.php',
                  :viewport_size => [780, 725],
                  :frame_size => [780, 2500],
                  :offset => [0, 660] })
          end
        end
      end
    end
  end
end
