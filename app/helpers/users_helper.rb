module UsersHelper
  
  def gravatar_for(user)
    email_address = user.email.downcase
    default_image = image_tag 'logo-small.png'
    image_tag "http://www.gravatar.com/avatar/#{::MD5::md5(email_address)}?d=#{default_image}", :id => 'gravatar'
  end

  def if_authorized?(action, resource, &block)
    if authorized?(action, resource)
      yield action, resource
    end
  end
end
