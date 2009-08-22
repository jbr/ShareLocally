config.cache_classes = false

config.whiny_nils = true

config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.action_mailer.raise_delivery_errors = true
class ActionMailer::Base
  define_and_alias :deliver!, :override do |mail|
    mail ||= @mail
    mail.subject = "Stormweight (Development): #{mail.to.to_sentence} #{mail.subject}"
    mail.to = "\"#{mail.to.to_sentence}\" <jacob+development@stormweight.com>"
    deliver_without_override! mail
  end
end
