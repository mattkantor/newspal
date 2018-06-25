require 'rails_helper'

RSpec.describe "News", type: :request do


  describe "GET /" do
    it "works! (now write some real specs)" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end



  describe "GET /follow?topic=Tom" do
    it "Should add Tom to the session cookie and return" do

      refer = 'http://localhost:3000/?'
      get follow_path, headers: { 'HTTP_REFERER' => refer }
      #expect(response).to have_http_status(200)
      assert_redirected_to refer

    end
  end
end
