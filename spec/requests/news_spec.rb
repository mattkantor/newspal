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
      follows = @following
      @follow_count = follows.count
      @request.env['HTTP_REFERER'] = 'http://localhost:3000/?'
      get follow_path
      #expect(response).to have_http_status(200)
      assert_redirected_to @request.env['HTTP_REFERER']
      new_follows = @following
      expect(new_follows).to equal(@follow_count + 1)

    end
  end
end
