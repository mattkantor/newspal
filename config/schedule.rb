# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 15.minutes do
  runner "Source.get_all_news"

end


every 10.minutes do

  runner "Item.update_ner_raw"
end

every 1.day at:['4:30 am'] do

  runner "Category.compute_daily_trends"

end


#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
