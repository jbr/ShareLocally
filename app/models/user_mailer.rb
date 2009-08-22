class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "#{base_url}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = base_url
  end
  
  protected
  
  def setup_email(user)
    recipients "#{user.email}"
    from "sharelocally"
    subject "[ShareLocally] "
    sent_on Time.now
    body[:user] = user
  end
    
  def base_url
    case RAILS_ENV
    when 'development'
      "http://#{`hostname`.strip}:3000"
    when 'production'
      "http://www.sharelocally.org"
    end
  end
end
