class CategoriesController < ApplicationController
  before_action :set_nav

  def set_nav
    @nav = "topics"
  end

  def index
    @page_title = "Topics"
    @categories = Category.open.all
    return
  end

end
