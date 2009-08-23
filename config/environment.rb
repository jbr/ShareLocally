RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem 'geokit'
  config.load_paths += %w( observers mailers ).map{|path| File.join(RAILS_ROOT, 'app', path)}
  
  config.active_record.observers = Dir["#{RAILS_ROOT}/app/observers/*.rb"].map do |f|
    f =~ /([a-z_]+)\.rb/
    $1.to_sym
  end

  config.time_zone = 'Pacific Time (US & Canada)'
end