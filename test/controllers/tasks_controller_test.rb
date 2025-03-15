require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
    sign_in @user
    @project = projects(:project_one)
    @task = tasks(:task_one)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      post tasks_url, params: { task: { description: @task.description, due_date: @task.due_date, level: @task.level, name: @task.name, project_id: @task.project_id, remarks: @task.remarks, start_date: @task.start_date, status: @task.status, user_id: @task.user_id } }
    end

    assert_redirected_to task_url(Task.last)
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { description: @task.description, due_date: @task.due_date, level: @task.level, name: @task.name, project_id: @task.project_id, remarks: @task.remarks, start_date: @task.start_date, status: @task.status, user_id: @task.user_id } }
    assert_redirected_to task_url(@task)
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end

  private

  def sign_in(user)
    raise ArgumentError, "User must have an email_address and password" unless user.email_address && user.password_digest
    post session_url, params: { session: { email_address: user.email_address, password: "password" } }
  end
end
