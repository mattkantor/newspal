class NewsController < ApplicationController
  before_action :get_top_keywords
  before_action :set_defaults




  def set_defaults
    @page_title = "Scoopy News"
    @following = session[:follows]||[]

  end

  def get_top_keywords
    @top_ents = Entity.top(10)
  end
  def refresh
    Source.get_all_news
    ahoy.track "refresh"
    redirect_to "/"
    return
  end

  def topics


  end

  def follow
    followed_topics = session[:follows] || []
    follow_topic = params[:topic]

    followed_topics << follow_topic

    session[:follows] = followed_topics.uniq
    redirect_to request.referer and return
  end

  def unfollow
    topic = params[:topic]
    followed_topics = session[:follows]||[]
    session[:follows] = followed_topics - [topic]
    redirect_to request.referer and return
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
      @source = Source.find(@channel.to_i)
      @items = @items.joins(:source).where("sources.id=?",@channel.to_i).order("published desc").all
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
      @page_title = "Search Results for '#{@filter}'"
      @add_follow = @filter
    end

    @layout = layout

    @items = @items.order("published desc").limit(70).all

  end

  def filter

  end
end
