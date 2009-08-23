config.cache_classes = true
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true
config.log_level = :debug
config.cache_store = :mem_cache_store

# config.action_controller.asset_host = "http://assets.example.com"

config.action_controller.asset_host =  "http://assets%d.sharelocally.org"
# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Enable threaded mode
# config.threadsafe!
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :location       => '/usr/sbin/sendmail',
  :arguments      => '-i -t -f sharelocally@sharelocally.org'
}
# 
# ActionMailer::Base.smtp_settings = {
#   :domain => 'sharelocally.org',
#   :user_name => 'sharelocally@sharelocally.org',
#   :password => 'sharel0cally',
#   :authentication => 'login'
# }