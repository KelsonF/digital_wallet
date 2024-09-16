require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one) # Ensure you have a valid user fixture
    @valid_login_attributes = { email: @user.email, password: "password123" }
    @invalid_login_attributes = { email: "wrong@example.com", password: "wrongpassword" }
  end

  test "should login user and return token" do
    post "/login", params: @valid_login_attributes, as: :json
    assert_response :ok
    assert_includes json_response.keys, "token"
  end

  # Test user login with invalid credentials
  test "should not login user with invalid credentials" do
    post "/login", params: @invalid_login_attributes, as: :json
    assert_response :unauthorized
    assert_includes json_response.keys, "error"
  end

  private

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
