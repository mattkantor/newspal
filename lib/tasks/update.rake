
task :update_news =>:environment do
  Source.get_all_news
end

task :clean_update =>:environment do

  Source.clear_and_get
end
