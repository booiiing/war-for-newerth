class NewsController < ApplicationController

  def show
    @new = New.find params[:id]
  end

  def new
    @new = New.new
  end
  
  def create
    @new = New.new params[:new]
    @new.poster = current_user || User.first
    if @new.save
      flash[:notice] = "Successfully created"
      render :text => '<script type="text/javascript">window.opener.location.reload();window.close();</script>'
    else
      flash[:error] = "Could not create"
      render :action => :edit
    end
  end

  def edit
    @new = New.find params[:id]
  end

  def update
    @new = New.find params[:id]
    @new.poster = current_user || User.first
    if @new.update_attributes params[:new]
      flash[:notice] = "Successfully updated"
      render :text => '<script type="text/javascript">window.opener.location.reload();window.close();</script>'
    else
      flash[:error] = "Could not update"
      render :actuib => :edit
    end
  end

  def destroy
    @new = New.find params[:id]
    if @new.destroy
      flash[:notice] = "Successfully updated"
    else
      flash[:error] = "Could not update"
    end
    redirect_back_or_default(:root)
  end
end
