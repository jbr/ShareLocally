class ItemsController < ApplicationController
  before_filter :login_required
  load_resource :user, :if_nil => :access_denied, :except => :index
  load_resource :user, :only => :index
  load_resource :item, :by => :id
  before_filter :user_must_be_current, :unless => proc{|c| c.instance_eval{@user.nil?}}
  
  def index
    if @user
      @items = @user.items
    else
      @items = User.find(:all, :origin => [current_user.lat, current_user.lng],
        :order => 'distance desc', :limit => 30, :include => :items).map(&:items).flatten
    end
  end
  
  def show
  end
  
  def new
    @item = @user.items.build
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
    @item = @user.items.build params[:item]
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