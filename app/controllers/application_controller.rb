class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_defaults
  before_action :get_top_keywords

  def current_permission
    @current_permission ||= ::Permissions.permission_for(current_user)
  end

  def set_defaults
    @page_title = "Scoopy News"
    @following = session[:follows]||[]

  end

  def get_top_keywords
    @top_ents = (Category.top_strings(12,3) - @following)[0..9]
  end

  def get_top_keywords_old
    @top_ents = (Entity.top_strings(20,3) - @following)[0..9]
  end

end
