class SearchQuery < ApplicationRecord
  belongs_to :user_session
  validates :text, presence: true
end
