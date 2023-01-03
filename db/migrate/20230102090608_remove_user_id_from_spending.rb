class RemoveUserIdFromSpending < ActiveRecord::Migration[7.0]
  def change
    remove_reference :spendings, :user, index: true
  end
end
