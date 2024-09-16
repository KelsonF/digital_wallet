require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  def setup
    @user = users(:one) # Assuming you have a fixture for User
    @transaction = @user.transactions.build(amount: 100, transaction_type: :deposit, description: "Initial deposit")
  end

  test "should be valid with valid attributes" do
    assert @transaction.valid?
  end

  test "amount should be present" do
    @transaction.amount = nil
    assert_not @transaction.valid?, "Transaction is valid without an amount"
  end

  test "amount should be greater than 0" do
    @transaction.amount = -1
    assert_not @transaction.valid?, "Transaction is valid with negative amount"
  end

  test "should not allow withdrawal more than balance" do
    @transaction.transaction_type = :withdrawal
    @transaction.amount = @user.balance + 100
    assert_not @transaction.valid?, "Allowed withdrawal more than balance"
  end
end
