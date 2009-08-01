class MatchesController < ApplicationController
  # GET /match/new
  # GET /match/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end
end
