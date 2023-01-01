class Spending < ApplicationRecord
  belongs_to :user
  belongs_to :spending_category
  validates_presence_of :amount, :description
end
