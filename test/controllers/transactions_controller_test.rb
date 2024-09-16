require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one) # Ensure you have a valid user fixture
    @transaction = transactions(:one) # Ensure you have a valid transaction fixture
    @valid_attributes = { amount: 100.0, transaction_type: "deposit", description: "Test Transaction" }
    @token = AuthService.encode(user_id: @user.id)
  end

  # Test the index action
  test "should get index" do
    get transactions_url, headers: { Authorization: "Bearer #{@token}" }
    assert_response :success
    assert_not_nil json_response["data"] # Assuming a JSON API response structure
  end

  test "should not create transaction with invalid attributes" do
    invalid_attributes = { amount: nil, transaction_type: "deposit" } # Missing required attributes
    post transactions_url, params: { transaction: invalid_attributes }, headers: { Authorization: "Bearer #{@token}" }

    assert_response :unprocessable_entity
  end

  private

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
