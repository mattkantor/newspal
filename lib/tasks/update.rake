
task :update_news =>:environment do
  Source.get_all_news
end

task :clean_update =>:environment do

  Source.clear_and_get
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
