class Source < ApplicationRecord

  def self.crawl_all
    Source.all.each do |s|
      s.news_getter
    end
  end

  def news_updater(res)

      puts "adding #{res}"
      i = Item.new(source_id: self.id, title:res.title, image_url:res.image, published:res.published, url:res.url, body: res.summary)
      i.save

  end

  def news_getter

    rss_results = []
    #xml = HTTParty.get(self.rss_url).body
    feed = Feedjira::Feed.fetch_and_parse self.rss_url
    entries = feed.entries
    entries.each do |result|
      puts result

      news_updater(result)
    end

  end

end
