load 'deploy' if respond_to?(:namespace)

set :application, "rock-scissors-paper"
set :user, "kleber"
set :use_sudo, false

set :scm, :git
set :repository, "git@github.com:klebervirgilio/Rock_Paper_or_Scissors_Game.git"
set :deploy_via, :remote_cache
set :deploy_to, "/home/kleber/apps/ruby/Rock_Paper_or_Scissors_Game"

role :app, "208.88.124.166"
role :web, "208.88.124.166"
role :db,  "208.88.124.166", :primary => true

set :runner, user
set :admin_runner, user

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C thin/production_config.yml -R config.ru start"
  end
 
  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C thin/production_config.yml -R config.ru stop"
  end
 
  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end
 
  # This will make sure that Capistrano doesn't try to run rake:migrate (this is not a Rails project!)
  task :cold do
    deploy.update
    deploy.start
  end
end

namespace :rsp do
  task :log do
    run "cat #{deploy_to}/current/log/thin.log"
  end
end