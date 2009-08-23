module UsersHelper
  
  def link_to_user user
    link_to "#{gravatar_for user, :size => 20} #{user.to_s}", user_url(user)
  end
  
  def gravatar_for(user, options = {})
    size = options.delete(:size) || 80
    options[:class] ||= 'gravatar'
    email_address = user.email.downcase
    default_image = image_tag 'logo-small.png'
    image_tag "http://www.gravatar.com/avatar/#{::MD5::md5(email_address)}?d=#{default_image}&s=#{size}", options
  end

  def if_authorized?(action, resource, &block)
    if authorized?(action, resource)
      yield action, resource
    end
  end
end
