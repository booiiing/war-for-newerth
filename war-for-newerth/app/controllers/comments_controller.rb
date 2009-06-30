class CommentsController < ApplicationController
  def create
    @comment = Comment.new params[:comment]
    @comment.poster = current_user
    if @comment.save
      flash[:notice] = "Successfully created"
      redirect_to :controller => :news, :action => :show, :id => params[:comment][:new_id]
    else
      flash[:error] = "Could not create"
      redirect_to :controller => :news, :action => :show, :id => params[:comment][:new_id]
    end
  end
end
