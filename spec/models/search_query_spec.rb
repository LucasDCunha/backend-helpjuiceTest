require 'rails_helper'

RSpec.describe SearchQuery, type: :model do
  it { should belong_to(:user_session) }
  it { should validate_presence_of(:text) }

  describe "valid factory" do
    it "is valid with valid attributes" do
      session = UserSession.create(ip: "123.123.123.123")
      query = session.search_queries.new(text: "test search")
      expect(query).to be_valid
    end
  end
end
