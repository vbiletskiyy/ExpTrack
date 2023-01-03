class User < ApplicationRecord
  has_secure_password

  has_many :user_spendings
  has_many :spendings, through: :user_spendings
end
