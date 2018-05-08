class NewsController < ApplicationController
  def refresh
    Source.get_all_news
    redirect_to "/"
    return
  end

  def index
    layout = params[:layout] || session[:layout] || "grid"
    session[:layout] = layout
    @filter = params[:filter]
    lean = params[:l]
    if lean
      lean = lean.to_i
    else
      lean = 0
    end

    items = Item.joins(:source).where("sources.leans=? or sources.leans=? or sources.leans=? or sources.leans=? or sources.leans=?",lean-2, lean+2, lean-1, lean, lean+1)

    if @filter!=""
      items = items.where("title like ?","%#{@filter}%")
    end

    @layout = layout

    @items = items.order("published desc").all

  end

  def filter

  end
end
