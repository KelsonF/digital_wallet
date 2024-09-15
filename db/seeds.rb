users = User.create!(
  [
    { name: 'Alice', email: 'alice@example.com', password_digest: "password1234" },
    { name: 'Bob', email: 'bob@example.com', password_digest: "password1234" },
    { name: 'Charlie', email: 'charlie@example.com', password_digest: "password1234" }
  ]
)

# Define some sample transactions
transactions = [
  { amount: 100.50, transaction_type: 1, user: users[0], description: "Lorem Ipsum" },
  { amount: 200.00, transaction_type: 2, user: users[1], description: "Lorem Ipsum" },
  { amount: 50.75, transaction_type: 1, user: users[2], description: "Lorem Ipsum" },
  { amount: 300.00, transaction_type: 2, user: users[0], description: "Lorem Ipsum" },
  { amount: 75.25, transaction_type: 2, user: users[1], description: "Lorem Ipsum" }
]

# Create transactions
Transaction.create!(transactions)
