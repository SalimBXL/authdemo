require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one) # Suppose qu'un fixture user_one existe
  end

  test "should create session with valid credentials" do
    sign_in @user
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "should not create session with invalid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "wrong_password" }
    assert_response :found
    assert_nil session[:user_id], "User ID should not be set in the session"
  end

  test "should destroy session" do
    delete session_path
    assert_response :redirect
    assert_redirected_to new_session_path
    assert_nil session[:user_id], "User ID was not cleared from the session"
  end

  private

  def sign_in(user)
    raise ArgumentError, "User must have an email_address and password" unless user.email_address && user.password_digest
    post session_url, params: { email_address: user.email_address, password: "password" }
  end
end
