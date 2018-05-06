class NewsController < ApplicationController
  def index
    layout = params[:layout] || session[:layout] || "grid"
    session[:layout] = layout
    @layout = layout
    #@topics = Item.find_topics
    lean = params[:l]


    if lean
      puts lean
      lean = lean.to_i
      @items = Item.joins(:source).where("sources.leans=? or sources.leans=? or sources.leans=? or sources.leans=? or sources.leans=?",lean-2, lean+2, lean-1, lean, lean+1).order("published desc").all

    else
      @items = Item.order("published desc").all
    end

  end

  def filter
    @items = Item.where("title like ?","%#{filter}%").order("published desc").all

  end
end
