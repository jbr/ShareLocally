Message.settings = YAML.load_file(RAILS_ROOT + '/config/email.yml')[RAILS_ENV].symbolize_keys