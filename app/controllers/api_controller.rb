class ApiController < ActionController::API
  include Response
  def index
    @news = Item.all
    json_response(@news)


  end

  def top_ten
    counts = CategoryCount.select("categories.*, items_categories.*").joins(:category).where("run_date = ?", Time.now.to_date-1).order("count desc").limit(10)
    return json_response(counts)
  end

  def stats
    cat_name = params[:name]
    counts = []
    add_to_stats = false
    unless cat_name.blank?
      cat = Category.where(name:cat_name).first
      unless cat.nil?
        counts = cat.category_counts.order("run_date asc").all
      end

    end

    return json_response(counts)
  end
end
