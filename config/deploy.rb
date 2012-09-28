#require "whenever/capistrano"
require "bundler/capistrano"

def run_remote_rake(rake_cmd)
  rake_args = ENV['RAKE_ARGS'].to_s.split(',')
  cmd = "cd #{deploy_to}/current && #{fetch(:rake, "rake")} RAILS_ENV=#{fetch(:rails_env, "production")} #{rake_cmd}"
  cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
  run cmd
  set :rakefile, nil if exists?(:rakefile)
end


#set :workers, { "archive" => 1, "mailing" => 3, "search_index, cache_warming" => 1 }
set :workers, { "mailing" => 3, "search_index, cache_warming" => 1 }

# RVM bootstrap
#$:.unshift(File .expand_path( "~/.rvm/lib" ))
set :rvm_ruby_string ,  'ruby-1.9.3-p194@askjane' #这个值是你要用rvm的gemset。名字要和系统里有的要一样。
#set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system
set :rvm_type ,  :user   # Don't use system-wide RVM
require 'rvm/capistrano'

set :stages, %w(online vv)
set :default_stage, "vv"
require 'capistrano/ext/multistage'

set :application, "bbtcms"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git
set :scm_username, 'git'
#set :repository,  "git@bbtang.com:bbtang/bbtcms.git"
# set :branch, "online"
set :branch, "master"
set :user, 'bbt'
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_env, 'production'
#set :deploy_to "/opt/#{application}"
set :deploy_to, "/home/#{user}/bbtang/#{application}"
#role :web, "nginx"                          # Your HTTP server, Apache/etc
#role :app, "nginx"                          # This may be the same as your `Web` server
#role :db,  "mysql", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"
#server "211.152.35.25", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
set :keep_releases, 15

after 'deploy:update_code', 'deploy:migrate'


#after "deploy:symlink", "restart_workers"
#after "deploy:symlink"
after "deploy:symlink", "restart_workers", "rvm:trust_rvmrc", "deploy:update_crontab"
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


  desc "start Resque Workers"
  task :start_workers, :roles => :db do
    #run_remote_rake "resque:restart_workers"
    run_remote_rake "COUNT=5 PIDFILE=./resque.pid BACKGROUND=yes QUEUE=#{application} RAILS_ENV=production environment resque:work"
  end
  desc "stop Resque Workers"
  task :stop_workers, :roles => :db do
    #run_remote_rake "resque:restart_workers"
    run_remote_rake "RAILS_ENV=production resque:stop_workers"
  end
  desc "Restart Resque Workers"
  task :restart_workers, :roles => :db do
    #run_remote_rake "resque:restart_workers"
    run_remote_rake "RAILS_ENV=production resque:stop_workers"
    run_remote_rake "COUNT=5 PIDFILE=./resque.pid BACKGROUND=yes QUEUE=#{application} RAILS_ENV=production environment resque:work"
  end


  desc "Write Crontab"
  task :update_crontab, :roles => :app do
    run "cd #{current_path}/ && whenever -i #{current_path}/config/schedule.rb --set environment=#{rails_env} --update-crontab #{application}"
  end

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end
namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end
# task for testing
task :uname do
  run "uname -a"
end
