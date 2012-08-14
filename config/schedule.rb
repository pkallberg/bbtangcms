# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
#whenever --update-crontab bbtangcms #appname
set :output, "#{Whenever.path}/log/whenever.log"
#set :output, File.expand_path('../log/whenever.log', __FILE__)
every 3.weeks do
  rake "bbtangcms:page_request:clean_older"
end
every 1.day do
  #command "echo 'today whenever running ..'"
  runner "puts '#{Date.today} whenever running ...'"
end
every '0 0 27-31 * *' do
  command "echo 'you can use raw cron syntax too'"
end
