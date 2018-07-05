from grabfeed.grabber import return_feed
feed = return_feed('http://techcrunch.com')
print(feed.rss)
