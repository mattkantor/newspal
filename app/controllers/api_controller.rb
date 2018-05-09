class ApiController < ActionController::API
  include Response
  def index
    @news = Item.all
    json_response(@news)


  end
end
