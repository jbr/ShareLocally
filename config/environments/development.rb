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

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = true
  class ActionMailer::Base
    def deliver_with_override!(mail = @mail)
      mail.subject = "Stormweight (Development): #{mail.to.to_sentence} #{mail.subject}"
      mail.to = "\"#{mail.to.to_sentence}\" <jacob+development@stormweight.com>"
      deliver_without_override!(mail)
    end
    alias_method_chain :deliver!, :override
  end
