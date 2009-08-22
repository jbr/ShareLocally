class RequestsController < ApplicationController
  load_resource :request, :by => :id
  
  def index
    @requests = Request.all
  end
  
  def show
  end
  
  def new
    @request = Request.new
  end
  
  def edit
  end
  
  def update
    @success = @request.update_attributes params[:request]
    respond_to do |format|
      format.html do
        @success ? redirect_to(request_url(@request)) : render(:action => :edit)
      end
      format.js
    end
  end
  
  def create
    @request = Request.new params[:request]
    @success = @request.save
    respond_to do |format|
      format.html do
        @success ? redirect_to(request_url(@request)) : render(:action => :new)
      end
      format.js
    end
  end
  
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url }
      format.js
    end
  end
end