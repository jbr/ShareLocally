class ItemsController < ApplicationController
  load_resource :user, :if_nil => :access_denied
  load_resource :item, :by => :id
  before_filter :user_must_be_current
  
  def index
    @items = Item.all
  end
  
  def show
  end
  
  def new
    @item = Item.new
  end
  
  def edit
  end
  
  def update
    @success = @item.update_attributes params[:item]
    respond_to do |format|
      format.html do
        @success ? redirect_to(user_item_url(@user, @item)) : render(:action => :edit)
      end
      format.js
    end
  end
  
  def create
    @item = Item.new params[:item]
    @success = @item.save
    respond_to do |format|
      format.html do
        @success ? redirect_to(user_item_url(@user, @item)) : render(:action => :new)
      end
      format.js
    end
  end
  
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to user_items_url(@user) }
      format.js
    end
  end
end