class NewsController < ApplicationController

  def refresh
    Source.get_all_news
    ahoy.track "refresh"
    redirect_to "/"
    return
  end

  def topics


  end

  def sources
    @page_title = "News Sources"
    @sources = Source.all
    @nav="sources"
  end


  def index
    @nav="news"
    @page_title = "News Home"
    layout = params[:layout] || session[:layout] || "list"
    session[:layout] = layout
    @items = Item
    @filter = params[:filter]
    @lean = params[:l]||"A"
    @channel = params[:channel]
    ahoy.track "home", {channel: @channel, lean:@lean, filter: @filter, layout:@layout}

    if @channel and @channel!=""
      @items = @items.joins(:source).where("source.id=?",@channel).order("published desc").all
      return
    end

    if @lean and @lean!="A"
      @lean = @lean.to_i
      @items = @items.joins(:source).where("sources.leans=? or sources.leans=? or sources.leans=?", @lean-1, @lean, @lean+1)

    else
      @lean = "A"
    end


    if @filter and @filter!=""
      @items = @items.where("title like ? or body like ?","%#{@filter}%","%#{@filter}%")
    end

    @layout = layout

    @items = @items.order("published desc").limit(70).all

  end

  def filter

  end
end
