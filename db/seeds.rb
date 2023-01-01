# Seeding users
user1 = User.create(name: "Igor", password: "123qweasd", email: "igor@email.com")
user2 = User.create(name: "Vasya", password: "123qweasd", email: "vasya@email.com")

#Seeding spending categories
spending_category1 = SpendingCategory.create(title: "Taxi")
spending_category2 = SpendingCategory.create(title: "Other")

# Seeding spendings
spending1 = Spending.create(description: "From home to job", amount: 120, user_id: user1.id, spending_category_id: spending_category1.id)
spending1 = Spending.create(description: "Donated to united24", amount: 120, user_id: user1.id, spending_category_id: spending_category2.id)
