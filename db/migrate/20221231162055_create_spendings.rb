class CreateSpendings < ActiveRecord::Migration[7.0]
  def change
    create_table :spendings do |t|
      t.text       :description
      t.integer    :amount, null: false
      t.belongs_to :user, null: false
      t.belongs_to :spending_category, null: false

      t.timestamps
    end
  end
end
