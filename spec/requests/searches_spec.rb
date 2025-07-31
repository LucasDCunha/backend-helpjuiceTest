require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /searches" do
    it "creates a search and redirects" do
      post "/searches", params: { text: "hello world" }
      expect(response).to have_http_status(302)
    end
  end
end
