class HomeController < ApplicationController
  def index
  end

  def contact
    @nav="Contact"
    @page_title = "Contact Us"
  end
end
