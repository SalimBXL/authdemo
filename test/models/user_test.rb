require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email_address" do
    user = User.new(password: "password")
    assert_not user.save, "Saved the user without an email_address"
  end

  test "should not save user with invalid email_address" do
    user = User.new(email_address: "invalid", password: "password")
    assert_not user.save, "Saved the user with an invalid email_address"
  end

  test "should save user with valid attributes" do
    user = User.new(email_address: "valid@example.com", password: "password")
    assert user.save, "Failed to save the user with valid attributes"
  end

  test "should normalize email_address" do
    user = User.create(email_address: "  TEST@Example.COM  ", password: "password")
    assert_equal "test@example.com", user.email_address, "Email address was not normalized"
  end
end
