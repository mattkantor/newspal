class Source < ApplicationRecord
  has_many :items

  after_update :news_getter

  validates_uniqueness_of :rss_url
  validates_presence_of :rss_url



  def sentiment(items)
    if items.size > 0
      items.reject{|item| item.sentiment.nil?}.collect{|i| i.sentiment||0 }.inject(:+).to_f/(items.size)
    else
      0
    end
  end

  def avg_sentiment
    sentiment(self.items)

  end

  def avg_sentiment_by_date(date)
    items = self.items.where("published > ? and published < ?", date, date)
    sentiment(items)
  end

  def self.clear_and_get
    Item.destroy_all
    Source.get_all_news
  end

  def self.get_all_news
    Source.all.each do |source|
      puts source.name
      source.news_getter
    end
  end



  def news_getter
    begin

      rss_results = []
      Feedjira::Feed.add_common_feed_element 'image'
      Feedjira::Feed.add_common_feed_element 'title'

      #xml = HTTParty.get(self.rss_url).body
      feed = Feedjira::Feed.fetch_and_parse self.rss_url
      title = feed.title ||""
      description = feed.description || title
      image_url = feed.image.url || feed.image || ""

      if !image_url.blank? and self.logo_url.blank?
        self.update_attribute("rss_url", image_url)
      end

      if !title.blank? and self.title.blank?
        self.update_attribute('title' , title)
      end

      #get high level info and update
      entries = feed.entries

      entries.each do |result|
        i = Item.new(source_id: self.id,title:result.title, image_url:result.image, published:(result.published||=DateTime.now), url:result.url, body: result.summary)
        i.save
      end
    rescue
    ensure
    end

  end

end
