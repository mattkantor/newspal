class NewsController < ApplicationController
  def refresh
    Source.get_all_news
    redirect_to "/"
    return
  end

  def index
    layout = params[:layout] || session[:layout] || "grid"
    session[:layout] = layout
    @items = Item
    @filter = params[:filter]
    @lean = params[:l]
    @channel = params[:channel]

    if @channel and @channel!=""
      @items = @items.joins(:source).where(source.id=@channel).order("published desc").all
      return
    end

    if @lean
      @lean = @lean.to_i
      @items = @items.joins(:source).where("sources.leans=? or sources.leans=? or sources.leans=?", @lean-1, @lean, @lean+1)

    else
      lean = 0
    end


    if @filter!=""
      @items = @items.where("title like ?","%#{@filter}%")
    end

    @layout = layout

    @items = @items.order("published desc").all

  end

  def filter

  end
end
