class UserMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  
  def self.do_batch
    User.all.each do |user|
      self.do_batch_request_notifications_for user
    end
  end
  
  def self.do_batch_request_notifications_for(user)
    requests = user.incoming_requests.all :conditions => {:notification_pending => true}
    deliver_request_notification user, requests unless requests.empty?
    requests.each {|r| r.update_attributes :notification_pending => false}
  end
  
  def request_notification(user, requests)
    setup_email(user)
    @subject += "#{pluralize requests.size, 'new request'}"
    @body[:requests] = requests
    @body[:url] = base_url
  end
  
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
  
  def forgotten_password(user)
    setup_email(user)
    @subject += "Forgot something?"
    @body[:url] = "#{base_url}/forgotten_passwords/#{user.activation_code}"
  end
  
  def new_message_notification(message)
    setup_email(message.to_user)
    @body[:message] = message
    @body[:url] = "#{base_url}/users/#{message.to_user.to_param}/messages/#{message.to_param}"
    from "#{message.from_user} <sharelocally@sharelocally.com>"
    @subject += "New Message from #{message.from_user}"
  end
  
  protected
  
  def setup_email(user)
    recipients "#{@user} <#{user.email}>"
    from "ShareLocally <sharelocally@sharelocally.org>"
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
