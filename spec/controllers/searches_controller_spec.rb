require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:ip) { "123.123.123.123" }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return(ip)
  end

  describe "POST #create" do
    it "creates a new UserSession on first search" do
      expect {
        post :create, params: { text: "hello world" }
      }.to change(UserSession, :count).by(1)
    end

    it "does not create UserSession twice for same IP" do
      2.times { post :create, params: { text: "hello world" } }
      expect(UserSession.count).to eq(1)
    end

    it "creates only the final search (avoids pyramid problem)" do
      post :create, params: { text: "what" }
      sleep 1
      post :create, params: { text: "what is" }
      sleep 1
      post :create, params: { text: "what is a good car" }

      expect(SearchQuery.count).to eq(1)
      expect(SearchQuery.last.text).to eq("what is a good car")
    end

    it "creates a new query if not continuation" do
      post :create, params: { text: "hello world" }
      post :create, params: { text: "how are you?" }

      expect(SearchQuery.count).to eq(2)
    end

    it "does not store blank queries" do
      expect {
        post :create, params: { text: "" }
      }.to_not change(SearchQuery, :count)
    end

    it "overwrites last query only if created within 30s" do
      post :create, params: { text: "first" }
      SearchQuery.last.update!(created_at: 5.minutes.ago)

      expect {
        post :create, params: { text: "first again" }
      }.to change(SearchQuery, :count).by(1)
    end
  end

  describe "GET #index" do
    it "returns popular searches grouped by text" do
      session = UserSession.create(ip: ip)
      2.times { session.search_queries.create!(text: "popular") }
      session.search_queries.create!(text: "less popular")

      get :index
      expect(assigns(:popular_searches).keys).to include("popular", "less popular")
      expect(assigns(:popular_searches)["popular"]).to eq(2)
    end
  end
end
