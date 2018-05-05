class NewsController < ApplicationController
  def index
    #@topics = Item.find_topics

    filter = params[:filter]
    if filter!=""
      @items = Item.where("title like ?","%#{filter}%").order("published desc").all
    else
      @items = Item.order("published desc").all
    end

  end
end
