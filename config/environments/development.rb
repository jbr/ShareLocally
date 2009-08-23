# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.action_mailer.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
    :tls => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "sharelocally.org",
    :authentication => :plain,
    :user_name => "sharelocally@sharelocally.org",
    :password => "sh4rel0cally" 
  }
  
  
  class ActionMailer::Base
    def deliver_with_override!(mail = @mail)
      mail.to = "\"#{mail.to.to_sentence}\" <jbr@sharelocally.org>"
      deliver_without_override!(mail)
    end
    alias_method_chain :deliver!, :override
  end
