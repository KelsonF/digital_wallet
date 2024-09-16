require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "John Doe", email: "john@example.com", password: "password")
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?, "User is valid without a name"
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?, "User is valid without an email"
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?, "Duplicate email allowed"
  end
end
