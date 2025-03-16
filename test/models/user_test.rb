require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_one)
  end

  describe "Should not save user..." do
    it "without email_address" do
      @user.email_address = nil
      assert_not @user.save, "Saved the user without an email_address"
    end

    it "with invalid email_address" do
      @user.email_address = "invalid"
      assert_not @user.save, "Saved the user with an invalid email_address"
    end
  end

  test "should save user with valid attributes" do
    assert @user.save, "Failed to save the user with valid attributes"
  end

  test "should normalize email_address" do
    assert_equal "one@example.com", @user.email_address, "Email address was not normalized"
  end

  describe "Return the name of the user..." do
    # Test de la méthode user_name
    it "returns the firstname if it exists" do
      assert_equal "UserOneFirstname", @user.user_name
    end

    it "returns the user name if it doesn't exist" do
      @user.firstname = nil
      assert_equal "one", @user.user_name
    end

    # Test de la méthode user_name
    test "returns the full name of the user if first and lastname exist" do
      assert_equal "UserOneFirstname UserOneLastname", @user.full_name
    end

    # Test de la méthode user_name
    test "returns the full name of the user if first and lastname don't exist" do
      @user.firstname = nil
      @user.lastname = nil
      assert_equal "one", @user.full_name
    end
  end

  # Test de la méthode tasks_for_current_user
  test "returns tasks associated with the current user" do
    user = users(:user_one) # Suppose qu'un fixture user_one existe
    task = tasks(:task_one) # Suppose qu'un fixture task_one existe et est lié à user_one
    assert_includes user.tasks_for_current_user, task
  end
end
