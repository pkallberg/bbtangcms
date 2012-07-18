# require "bundler/capistrano"

# RVM bootstrap   
$:.unshift(File .expand_path( "~/.rvm/lib" ))   
set :rvm_ruby_string ,  'ruby-1.9.3-p194@askjane' #这个值是你要用rvm的gemset。名字要和系统里有的要一样。   
set :rvm_type ,  :user   # Don't use system-wide RVM   
require 'rvm/capistrano'

set :application, "bbtcms"
set :repository,  "git@bbtang.com:bbtang/bbtcms.git"
#set :deploy_to "/opt/#{application}"
set :deploy_to, "/home/bbt/bbtang/#{application}"

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git
set :scm_username, 'git'
# set :branch, "online"
set :branch, "master"
set :user, 'bbt'
set :use_sudo, false

set :deploy_via, :remote_cache

#role :web, "nginx"                          # Your HTTP server, Apache/etc
#role :app, "nginx"                          # This may be the same as your `Web` server
#role :db,  "mysql", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"
server "211.152.35.25", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
set :keep_releases, 15
after "deploy:restart", "deploy:cleanup"

after 'deploy:update_code', 'deploy:migrate'

after "deploy", "rvm:trust_rvmrc"
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do

  task :start, :roles => :app, :except => { :no_release => true } do
    #run "cd #{current_path} && passenger start --socket /tmp/passenger.socket --daemonize --environment production"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    #run "cd #{current_path} && passenger stop --pid-file tmp/pids/passenger.pid"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end
