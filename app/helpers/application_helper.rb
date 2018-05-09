module ApplicationHelper
  def show_leans(item)
    if item.source.leans >3
      return "Very Conservative"
    elif item.source.leans<-3
      return "Very Liberal"
    elsif item.source.leans>1
      return "Conservative"
    elsif item.source.leans < -1
      return "Liberal"
    else
      return "Neutral"
    end
  end
end
