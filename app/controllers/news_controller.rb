class NewsController < ApplicationController


  include Response




  def refresh
    Source.get_all_news
    ahoy.track "refresh"
    redirect_to "/"
    return
  end

  def topics


  end

  def how
    @nav="How"
    @page_title = "How we do it"
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
    @filter = (params[:filter]||"")
    @lean = params[:l]||"A"
    @channel = params[:channel]
    ahoy.track "home", {channel: @channel, lean:@lean, filter: @filter.downcase, layout:@layout}

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

    if @show_following and !@following.empty?
      @following.each do |f|
        @items = @items.where("lower(title) like ? or lower(body) like ?","%#{f}%","%#{f}%")
      end
    end


    if @filter and @filter!=""
      @items = @items.where("lower(title) like ? or lower(body) like ?","%#{@filter.downcase}%","%#{@filter.downcase}%")
      @page_title = "Search Results for '#{@filter}'"
      @add_follow = @filter
    end

    @layout = layout

    @items = @items.order("published desc").limit(70).all

  end

  def filter

  end
end
