class NewsController < ApplicationController
  def index

    @items = Item.order("published desc").all
  end
end
