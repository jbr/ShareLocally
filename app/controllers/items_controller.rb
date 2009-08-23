class ItemsController < ApplicationController
  before_filter :login_required
  load_resource :user, :if_nil => :access_denied, :except => :index
  load_resource :user, :only => :index
  load_resource :item, :by => :id
  before_filter :user_must_be_current, :unless => proc{|c| c.instance_eval{@user.nil?}}

  
  def index
    if @user && @user == current_user
      @items = @user.items.find :all, :origin => current_user, :order => "distance desc", :limit => 30
    else
      @items = Item.search params[:search], current_user
      render :template => 'items/search'
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
        if @success
          flash[:notice] = "Thanks! #{@item} saved."
          redirect_to(new_user_item_url(@user))
        else
          flash[:error] = "Whoops, something went wrong.  Let's take a look"
          render(:action => :new)
        end
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