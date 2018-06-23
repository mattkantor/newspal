require 'rails_helper'

RSpec.describe NewsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #follow" do
    it "adds a follow topic and redirects" do
      refer = 'http://localhost:3000/?'
      @request.headers['HTTP_REFERER'] = refer

      get :follow, params: {topic:"Tom"}

      expect(session[:follows]).to eq(["Tom"])
      expect(response).to redirect_to(refer)
    end
  end



end
