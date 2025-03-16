require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
    sign_in @user
    @project = projects(:project_one)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    unique_name = "#{@project.name}_#{SecureRandom.hex(4)}" # Génère un nom unique
    assert_difference("Project.count") do
      post projects_url, params: { project: { description: @project.description, name: unique_name, user_id: @user.id } }
    end

    if Project.last.errors.any?
      puts "Validation errors: #{Project.last.errors.full_messages}"
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { description: @project.description, name: @project.name, user_id: @user.id } }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project" do
    assert_difference("Project.count", -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end

  private

  def sign_in(user)
    raise ArgumentError, "User must have an email_address and password" unless user.email_address && user.password_digest
    #post session_url, params: { session: { email_address: user.email_address, password: "password" } }
    post session_url, params: { email_address: user.email_address, password: "password" }
  end
end
