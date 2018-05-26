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
