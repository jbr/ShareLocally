module UsersHelper
  
  def link_to_user user
    link_to "#{gravatar_for user, :size => 20} #{user.to_s}", user_url(user)
  end
  
  def gravatar_for(user, options = {})
    size = options.delete(:size) || 80
    url = gravatar_url_for(user, size)
    options[:class] ||= 'gravatar'
    image_tag url, options
  end
  
  def gravatar_url_for(user, size)
    email_address = user.email.downcase
    default_image = "http://www.sharelocally.org/images/default-head-#{size}.png"
    "http://www.gravatar.com/avatar/#{::MD5::md5(email_address)}?d=#{default_image}&s=#{size}"
  end

  def if_authorized?(action, resource, &block)
    if authorized?(action, resource)
      yield action, resource
    end
  end
  
  
  def empty_profile?
    %w(full_name phone about).all? {|column| current_user.send(column.to_s).blank?}
  end
  
  def not_enough_items?
    current_user.items.count < 3
  end
  
  def no_outgoing_requests?
    current_user.outgoing_requests.empty?
  end
  
  def check_for(boolean, text, url)
    if boolean
      "[&nbsp;&nbsp;] #{link_to text, url}"
    else
      "[x] #{content_tag 'strike', text}"
    end
  end
end
