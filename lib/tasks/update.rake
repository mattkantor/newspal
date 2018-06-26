
task :update_news =>:environment do
  Source.get_all_news
end

task :clean_update =>:environment do

  Source.clear_and_get
end

task :compute_daily_trends do
  items_per_day = Item.where("published > ? and published < ?",(DateTime.now).midnight,(DateTime.now+1).midnight)
  ents_per_day = []
  items_per_day.each do | item |

    ents = item.entities.collect{|e|e.name}
    ents_per_day << ents.uniq!

  end


end
desc "create categories"
task create_categories: :environment do
  Category.build_from_entities
  puts "There are currently #{Category.count} categories total"
  Category.compute_daily_trends 
end


desc 'Counter cache for items has many entities'

task task_counter: :environment do
  Item.reset_column_information
  Item.find_each do |p|
    Item.reset_counters p.id, :entities
  end
end

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

task :export_to_seeds => :environment do

  sources = Source.all
  output = File.open( "db/seeds_sources.rb","w" )

  sources.each do |s|
    line="Source.create!(name:'#{s.name}', rss_url:'#{s.rss_url}', logo_url:'#{s.logo_url}',leans:'#{s.leans}')\n"
    output << line


  end
  output.close
end
