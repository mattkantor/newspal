class Source < ApplicationRecord
  has_many :items

  validates_uniqueness_of :rss_url
  def self.clear_and_get
    Item.destroy_all
    Source.get_all_news
  end

  def self.get_all_news
    Source.all.each do |source|
      source.news_getter
    end
  end


  def news_getter

    rss_results = []
    #xml = HTTParty.get(self.rss_url).body
    feed = Feedjira::Feed.fetch_and_parse self.rss_url
    entries = feed.entries
    entries.each do |result|
      puts result.to_s
      i = Item.new(source_id: self.id,title:result.title, image_url:result.image, published:result.published, url:result.url, body: result.summary)
      i.save
    end

  end

end
