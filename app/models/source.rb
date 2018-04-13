class Source < ApplicationRecord

  validates_uniqueness_of :rss_url

  def self.get_all_news
    Source.all.each do |source|
      source.news_getter
    end
  end

  def news_updater(res)

      puts "adding #{res.title}"
      i = Item.new(title:res.title, image:res.image, published:res.date, url:res.link, body: res.description)
      i.save

  end

  def news_getter

    rss_results = []
    #xml = HTTParty.get(self.rss_url).body
    feed = Feedjira::Feed.fetch_and_parse self.rss_url
    entries = feed.entries
    entries.each do |result|
      puts result
      result = { title: result.title,image:result.image, date: result.published, link: result.url, description: result.summary }
      news_updater(result)
    end

  end

end
