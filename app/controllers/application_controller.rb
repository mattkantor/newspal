class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :get_top_keywords
  before_action :set_defaults
  
  def set_defaults
    @page_title = "Scoopy News"
  end

  def get_top_keywords
    @top_ents = Entity.top(10)
  end

end
