class RequestsController < ApplicationController
  before_filter :login_required
  load_resource :item, :if_nil => :access_denied
  load_resource :request, :by => :id, :only => :destroy 
  
  def create
    @request = @item.requests.build :user => current_user
    @success = @request.save
    respond_to do |format|
      format.html do
        flash[:error] = "You have already requested #{@item}." unless @success
        redirect_to item_url(@item)
      end
      format.js
    end
  end
  
  def destroy
    unless [@request.user, @request.item.user].include? current_user
      return access_denied
    end
    
    @success = @request.destroy
    respond_to do |format|
      format.html { redirect_to item_url(@item) }
      format.js
    end
  end
end