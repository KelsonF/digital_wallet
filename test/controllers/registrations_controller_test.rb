require "test_helper"

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @valid_attributes = { name: "John Doe", email: "john.doe@example.com", password: "password123" }
    @invalid_attributes = { name: "", email: "invalid", password: "short" }
  end

  # Test user registration with valid attributes
  test "should register user and return token" do
    assert_difference("User.count") do
      post "/register", params: @valid_attributes, as: :json
    end
    assert_response :created
    assert_includes json_response.keys, "token"
  end

  # Test user registration with invalid attributes
  test "should not register user with invalid attributes" do
    assert_no_difference("User.count") do
      post "/register", params: @invalid_attributes, as: :json
    end
    assert_response :unprocessable_entity
    assert_includes json_response.keys, "errors"
  end

  private

  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end
