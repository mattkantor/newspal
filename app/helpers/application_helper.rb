module ApplicationHelper
  def show_leans(leans)
    if leans >3
      return "Very Conservative"
    elif leans <-3
      return "Very Liberal"
    elsif leans>1
      return "Conservative"
    elsif leans < -1
      return "Liberal"
    else
      return "Neutral"
    end
  end

  def sentiment_badge(sentiment)
    if sentiment > 0
      badge="success"
    elsif sentiment<0
      badge="danger"
    else
      badge="info"
    end

   "<small class=\"badge badge-#{badge}\">#{sentiment.to_d.truncate(3)}</small>".html_safe
  end

  def nav_item(title,route, fa_code, active_rule)
    html="<li class='nav-item '><a href=#{route} class='nav-link #{active_rule ? "active" : ""}'>"
    html+= "<i class='nav-icon fa fa-#{fa_code}'></i>"
    html+= "<p>#{title}</p></a></li>"
    html.html_safe
  end

  def show_sentiment(item)
    sentiment = item.sentiment
    if sentiment.nil?
      ret= "Unknown"
    elsif sentiment > 0.25
      ret= "Positive (#{sentiment.to_s})"
    elsif sentiment < -0.25
      ret= "Negative (#{sentiment.to_s})"
    else
      ret= "Neutral (#{sentiment.to_s})"
    end
    ret

  end

end
