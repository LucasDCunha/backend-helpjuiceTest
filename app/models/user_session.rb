class UserSession < ApplicationRecord
  has_many :search_queries, dependent: :destroy
end
