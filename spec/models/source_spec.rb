require 'rails_helper'

#https://github.com/bblimke/webmock
describe Source  do
  fixtures :sources
    before :each do
      Item.destroy_all
      
      stub_request(:any, "http://rss.cnn.com/rss/cnn_topstories.rss").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'cnnrss.xml')), status: 200)
      stub_request(:any, "http://www.msnbc.com/feeds/latest").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'msnbc.xml')), status: 200)
      stub_request(:any, "http://thehill.com/rss/syndicator/19109").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'thehill.xml')), status: 200)
      stub_request(:any, "http://feeds.reuters.com/reuters/topNews").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'reuters.xml')), status: 200)
      stub_request(:any, "https://www.politico.com/rss/politics08.xml").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'politico.xml')), status: 200)
      stub_request(:any, "https://www.cnbc.com/id/100003114/device/rss/rss.html").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'cnbc.xml')), status: 200)
      stub_request(:any, "http://feeds.foxnews.com/foxnews/politics").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'fox_politics.xml')), status: 200)
      stub_request(:any, "http://feeds.feedburner.com/breitbart").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'breitbart.xml')), status: 200)
      stub_request(:any, "http://feeds.bbci.co.uk/news/rss.xml").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'bbc.xml')), status: 200)
      stub_request(:any, "https://www.theguardian.com/world/rss").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'guardian.xml')), status: 200)
      stub_request(:any, "http://www.mcclatchydc.com/news/?getXmlFeed=true&widgetContentId=712015&widgetName=rssfeed
").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'mcclatchy.xml')), status: 200)
      stub_request(:any, "http://www.emptybroken.com/").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'empty_borken.xml')), status: 200)

  #   @source = create(:source)
    end

  context "with 1 source" do
    it "Should successfully parse all the rss files" do
      Source.get_all_news
      expect(Item.count).to eq(321)
    end
  end

end
