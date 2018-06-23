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
    #begin

      rss_results = []
      Feedjira::Feed.add_common_feed_element 'image'
      Feedjira::Feed.add_common_feed_element 'title'

      #xml = HTTParty.get(self.rss_url).body
      begin
        feed = Feedjira::Feed.fetch_and_parse self.rss_url
        entries = feed.entries
      rescue => exception
        Raven.capture_message("Feed #{self.name} is not pulling clean data")
        entries = []
      end

      entries.each do |result|
        title = result.title ||""
        summary = result.summary||""
        if title.length + summary.length > 50
          i = Item.new(source_id: self.id,title:result.title, image_url:result.image, published:(result.published||=DateTime.now), url:result.url, body: result.summary)
          i.save
        end
      end

      if feed and feed.respond_to? :title
        title = feed.title ||""
        if !title.blank? and self.name.blank?
          self.update_attribute('name' , title)
        end
      else
        #puts("feed has no attibute title")
      end

      if feed and feed.respond_to? :image
        if feed.image.class.name=="String"
          image_url = feed.image
        elsif feed.image.respond_to? :url
          image_url=feed.image.url
        else
          image_url=""
        end
        if !image_url.blank? and self.logo_url.blank?
          self.update_attribute("rss_url", image_url)
        end
      else
        #puts("feed has no attibute image")
      end



    #rescue => exception
      #Raven.capture_exception(exception)

    #ensure
    #end

  end

end
