require 'rails_helper'

RSpec.describe UserSession, type: :model do
  it { should have_many(:search_queries).dependent(:destroy) }
end
