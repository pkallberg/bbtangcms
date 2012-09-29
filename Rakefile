#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

BBTangCMS::Application.load_tasks
require 'rake/dsl_definition'
require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] ||= '*'
  #for redistogo on heroku http://stackoverflow.com/questions/2611747/rails-resque-workers-fail-with-pgerror-server-closed-the-connection-unexpectedl
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end

namespace :resque do
  desc "let resque workers always load the rails environment"
  task :setup => :environment do
  end

  desc "kill all workers (using -QUIT), god will take care of them"
  task :stop_workers => :environment do
    pids = Array.new
    #application = Rails.application.class.parent_name.downcase
    application = "bbtcms" #base on deploy.rb :application
    Resque.workers.each do |worker|
      if worker.to_s.end_with? application
        pids << worker.to_s.split(/:/).second
      end
    end

    if pids.size > 0
      system("kill -QUIT #{pids.join(' ')}")
    end

    # god should handle the restart
  end
end


####run below command
#Let's start a worker to run file_serve jobs:
#$ cd app_root
#COUNT=5 PIDFILE=./resque.pid BACKGROUND=yes QUEUE=* RAILS_ENV=production rake environment resque:work
#VVERBOSE=true COUNT=5  PIDFILE=./resque.pid QUEUE=* RAILS_ENV=production rake environment resque:work
#COUNT=5 PIDFILE=./resque.pid QUEUE=* RAILS_ENV=development rake environment resque:work
#rake RAILS_ENV=production resque:stop_workers
