module ApplicationHelper
  def show_leans(item)
    if item.source.leans==0
      return "Neutral"
    elsif item.source.leans>1
      return "Conservative"
    elsif item.source.leans < -1
      return "Liberal"
    else
      return "Neutral"
    end
  end
end
