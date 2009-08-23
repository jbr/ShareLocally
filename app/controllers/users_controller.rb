class UsersController < ApplicationController
  geocode_ip_address
  
  load_resource :user, :by => :id, :only => [:suspend, :unsuspend, :destroy, :purge, :show]
  before_filter :access_denied, :only => [:new, :activate, :create], :if => :logged_in?
  before_filter :user_must_be_current, :only => [:edit, :update]
  before_filter :user_must_have_access, :only => :show
  
  def index
    if logged_in?
      redirect_to user_url(current_user)
    else
      redirect_to brochure_url(:page => 'about')
    end
  end
  
  def show
    if @user == current_user
      render :template => 'users/home'
    end
  end
  
  def edit
  end
  
  def new
    @user = User.new :address => session[:geo_location].try(:full_address)
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We just sent an email to #{@user.email} with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def update
    @success = @user.update_attributes params[:user]
    respond_to do |format|
      format.html do
        @success ? redirect_to(user_url(@user)) : render(:action => :edit)
      end
      format.js
    end
  end
    

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  private
  def user_must_have_access
    unless @user && current_user &&
      (@user == current_user || current_user.has_access_to_user(@user))
      access_denied
    end
  end
end
