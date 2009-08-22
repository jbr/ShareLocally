class BrochureController < ApplicationController
  def index
    
    default = 'about'
    if params[:page].blank?
      redirect_to lists_url and return if logged_in? && !current_user.admin?
      params[:page] = default
    end
    
    unless path = template_exists?(File.join('brochure', params[:page]))
      path = "brochure/#{default}"
      params[:page] = default
    end
    params[:action] = params[:page]
    render :template => path
    # 
    # page = Rails.cache.fetch path do
    #   render_to_string :template => path
    # end
    # 
    # render :text => page
  end
  
  def template_exists?(path)
    self.view_paths.find_template(path, response.template.template_format)
  rescue ActionView::MissingTemplate
    false
  end
end
