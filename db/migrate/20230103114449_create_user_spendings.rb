class CreateUserSpendings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_spendings do |t|
      t.integer    :sent_by
      t.boolean    :sent
      t.belongs_to :user, null: false
      t.belongs_to :spending, null: false

      t.timestamps
    end
  end
end
