FactoryBot.define do
  factory :source do
    name "CNN"
    rss_url "http://rss.cnn.com/rss/cnn_topstories.rss"
    leans -1

  end
  # factory :source do
  #   name "MSNBC"
  #   rss_url "http://rss.msnbc.msn.com/id/3032091/device/rss/rss.xml"
  #   leans -2
  # end
end
