require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one) # Ensure you have a valid user fixture
    @transaction = transactions(:one) # Ensure you have a valid transaction fixture
    @valid_attributes = { amount: 100.0, transaction_type: "credit", description: "Test Transaction" }
    @token = AuthService.encode(user_id: @user.id) # Use AuthService to generate JWT token
  end

  # Test the index action
  test "should get index" do
    get transactions_url, headers: { Authorization: "Bearer #{@token}" }
    assert_response :success
    assert_not_nil json_response["data"] # Assuming a JSON API response structure
  end

  # Test the show action
  test "should show transaction" do
    get transaction_url(@transaction), headers: { Authorization: "Bearer #{@token}" }
    assert_response :success
    assert_equal @transaction.id, json_response["data"]["id"]
  end

  # Test the create action
  test "should create transaction" do
    assert_difference("Transaction.count") do
      post transactions_url, params: { transaction: @valid_attributes }, headers: { Authorization: "Bearer #{@token}" }
    end
    assert_response :created
    assert_equal @valid_attributes[:amount], json_response["data"]["attributes"]["amount"]
  end

  test "should not create transaction with invalid attributes" do
    assert_no_difference("Transaction.count") do
      post transactions_url, params: { transaction: { amount: nil, transaction_type: "credit" } }, headers: { Authorization: "Bearer #{@token}" }
    end
    assert_response :unprocessable_entity
  end

  # Test the balance action
  test "should get balance" do
    get balance_transactions_url, headers: { Authorization: "Bearer #{@token}" }
    assert_response :success
    assert_equal @user.balance, json_response["data"]
  end

  private

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
