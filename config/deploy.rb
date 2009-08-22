set :application, "sharelocally"
set :deploy_to, "/var/www/apps/#{application}"
default_run_options[:pty] = true
set :repository,  "git@github.com:railsrumble/rr09-team-237.git"
set :scm, "git"

role :app, "sharelocally.org"
role :web, "sharelocally.org"
role :db,  "sharelocally.org", :primary => true

namespace :deploy do
  task :restart do
    sudo "monit -g sharelocally restart all"
  end
  
  task :start do
    sudo "monit -g sharelocally start all"
  end
  
  task :stop do
    sudo "monit -g sharelocally stop all"
  end
end

namespace :monit do
  task :status do
    sudo "monit status"
  end
end
