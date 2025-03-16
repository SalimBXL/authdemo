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

  describe "Creating project..." do
    it "should get new" do
      get new_project_url
      assert_response :success
    end

    it "should create project" do
      unique_name = "#{@project.name}_#{SecureRandom.hex(4)}" # Génère un nom unique
      assert_difference("Project.count") do
        post projects_url, params: { project: { description: @project.description, name: unique_name, user_id: @user.id } }
      end
      if Project.last.errors.any?
        puts "Validation errors: #{Project.last.errors.full_messages}"
      end
      assert_redirected_to project_url(Project.last)
    end

    it "should not create project" do
      assert_difference("Project.count", +0) do
        @project.name = nil
        post projects_url, params: { project: { description: @project.description, name: @project.name, user_id: @user.id } }
      end
      assert_response :unprocessable_entity
    end
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  describe "Editing project..." do
    it "should get edit" do
      get edit_project_url(@project)
      assert_response :success
    end

    it "should update project" do
      patch project_url(@project), params: { project: { description: @project.description, name: @project.name, user_id: @user.id } }
      assert_redirected_to project_url(@project)
    end

    it "should not update project" do
      @project.name = nil
      patch project_url(@project), params: { project: { description: @project.description, name: @project.name, user_id: @user.id } }
      assert_response :unprocessable_entity
    end
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
    post session_url, params: { email_address: user.email_address, password: "password" }
  end
end
