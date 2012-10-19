# encoding: utf-8
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
=begin
The default job types that ship with Whenever are defined like so:

job_type :command, ":task :output"
job_type :rake,    "cd :path && RAILS_ENV=:environment bundle exec rake :task --silent :output"
job_type :runner,  "cd :path && script/rails runner -e :environment ':task' :output"
job_type :script,  "cd :path && RAILS_ENV=:environment bundle exec script/:task :output"
这里有crontab文件条目的一些例子：
30 21 * * * /usr/local/apache/bin/apachectl restart
上面的例子表示每晚的21:30重启apache。
45 4 1,10,22 * * /usr/local/apache/bin/apachectl restart
上面的例子表示每月1、10、22日的4 : 45重启apache。
10 1 * * 6,0 /usr/local/apache/bin/apachectl restart
上面的例子表示每周六、周日的1 : 10重启apache。
0,30 18-23 * * * /usr/local/apache/bin/apachectl restart
上面的例子表示在每天18 : 00至23 : 00之间每隔30分钟重启apache。
0 23 * * 6 /usr/local/apache/bin/apachectl restart
上面的例子表示每星期六的11 : 00 pm重启apache。
0 */1 * * * /usr/local/apache/bin/apachectl restart
每一小时重启apache
* 23-7/1 * * * /usr/local/apache/bin/apachectl restart
晚上11点到早上7点之间，每隔一小时重启apache
0 11 4 * mon-wed /usr/local/apache/bin/apachectl restart
每月的4号与每周一到周三的11点重启apache
0 4 1 jan * /usr/local/apache/bin/apachectl restart
一月一号的4点重启apache
=end
#whenever -i  config/schedule.rb -s environment=development --update-crontab bbtangcms

set :output, "#{Whenever.path}/log/whenever.log"
#set :output, File.join(Whenever.path, "log", "whenever.log")

every 3.weeks do
  rake "bbtangcms:page_request:clean_older"
end

every 1.day do
  #command "echo 'today whenever running ..'"
  runner "puts '#{Date.today} whenever running ...'"
end

every 10.minutes do
  #command "echo 'today whenever running ..'"
   rake "bbtangcms:notify:new_question_notify"
end

every '0 0 27-31 * *' do
  command "echo 'you can use raw cron syntax too'"
end

every 1.day, :at => '2:00 am' do
  runner "puts '#{DateTime.now} begin to send user_birthday_notify ...'"
  rake "bbtangcms:notify:user_birthday_notify"
end

every '0 3 1 * *' do
  runner "puts '#{DateTime.now} begin to send monthly_notify ...'"
  #rake "bbtangcms:notify:monthly_notify"
end

every '10 2 * * MON' do
  runner "puts '#{DateTime.now} begin to send weekly_notify ...'"
  #rake "bbtangcms:notify:weekly_notify"
end

every 1.day, :at => '1:00 am' do
  runner "puts '#{DateTime.now} begin to send user_birthday_notify ...'"
  #rake "bbtangcms:notify:user_birthday_notify"
end

every 1.day, :at => '1:30 am' do
  runner "puts '#{DateTime.now} begin to send baby_birthday_notify ...'"
  #rake "bbtangcms:notify:baby_birthday_notify"
end

every 1.day, :at => '0:30 am' do
  rake "assets:precompile"
  command "touch #{Whenever.path}/tmp/restart.txt"
end
