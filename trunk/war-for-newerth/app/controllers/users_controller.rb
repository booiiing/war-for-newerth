class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
    render :action => :show unless @user == current_user or current_user.is_admin? # prevents anyone to forge a request and edit an user
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes(params[:user]) if @user == current_user or current_user.is_admin?
    if params[:user][:clan_id] and @user.clan.nil?
      @user.update_attribute(:clan_id, params[:user][:clan_id])
    end
    
    render :action => :show
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
end
