require "rails_helper"

RSpec.describe NewsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/").to route_to("news#index")
    end

    it "routes to #new" do
      expect(:get => "/?l=A&filter=Joe").to route_to("news#index", :filter=>"Joe", :l=>"A")
    end

    it "routes to #show" do
      expect(:get => "/follow?topic=Tom").to route_to("news#follow", :topic=>"Tom")
    end

    it "routes to #edit" do
      expect(:get => "/unfollow?topic=Tom").to route_to("news#unfollow", :topic=>"Tom")
    end


  end
end
