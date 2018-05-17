class Submission < ApplicationRecord

  validates_presence_of :rss_url
  validates_presence_of :name
  validates_uniqueness_of :rss_url

  before_save :check_rss

  def check_rss
    
  end




end
