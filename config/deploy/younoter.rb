set :user, 'andersen'
set :deploy_to, "/home/#{user}/deployments/#{application}"
set :rails_env, "production"
set :repository,  "git@younoter.com:bbtang/bbtcms.git"
server "younoter.com", :app, :web, :db, :primary => true