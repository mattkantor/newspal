require 'rails_helper'

#https://github.com/bblimke/webmock
describe Source  do
  before :each do
    @source = create(:source)
  end

  context "with 1 source" do
    it "Should successfully parse CNNs rss file" do
      stub_request(:any, "http://rss.cnn.com/rss/cnn_topstories.rss").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'cnnrss.xml')), status: 200)
      stub_request(:any, "http://rss.msnbc.msn.com/id/3032091/device/rss/rss.xml").
      to_return(body: File.new(Rails.root.join('spec','fixtures', 'msnbc.xml')), status: 200)

      @source.class.get_all_news
      expect(Item.count).to eq(69)
    end
  end

end
