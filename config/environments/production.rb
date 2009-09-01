config.cache_classes = true
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true
config.log_level = :debug
config.cache_store = :mem_cache_store

config.action_controller.asset_host =  "http://assets%d.sharelocally.org"

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :location       => '/usr/sbin/sendmail',
  :arguments      => '-i -t -f sharelocally@sharelocally.org'
}
