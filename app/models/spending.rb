class Spending < ApplicationRecord
  has_many :user_spendings
  has_many :users, through: :users_spendings
  belongs_to :spending_category
  validates_presence_of :amount, :description
end
