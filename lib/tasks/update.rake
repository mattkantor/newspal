
task :update_news =>:environment do
  Source.get_all_news
end



task :compute_daily_trends=>:environment do
  Category.compute_daily_trends(Time.now.to_date-2)

end


desc "create categories"
task create_categories: :environment do

  Category.build_from_entities
  puts "There are currently #{Category.count} categories total"
  Category.compute_daily_trends
end


desc 'Counter cache for items has many entities'



task :build_ner => :environment do
  Item.update_ner_raw
end

task :update_ner => :environment do
  increment = 0
  Item.all.each do |item|
    count = item.entities.count
    if count ==0
      item.update_ner
      increment = increment + 1
      puts "updating #{increment} news item (#{item.title})"
    end
  end
end
