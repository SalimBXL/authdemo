require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_one)
    @project = projects(:project_one)
  end

  test "should not save task without name" do
    task = Task.new(project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today, due_date: Date.today + 1.month)
    assert_not task.save, "Saved the task without a name"
  end

  test "should not save task without project" do
    task = Task.new(name: "Task Name", user: @user, status: :new, criticity: 2, start_date: Date.today, due_date: Date.today + 1.month)
    assert_not task.save, "Saved the task without a project"
  end

  test "should not save task without user" do
    task = Task.new(name: "Task Name", project: @project, status: :new, criticity: 2, start_date: Date.today, due_date: Date.today + 1.month)
    assert_not task.save, "Saved the task without a user"
  end

  test "should not save task if due_date is before start_date" do
    task = Task.new(name: "Task Name", project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today, due_date: Date.yesterday)
    assert_not task.save, "Saved the task with a due_date before start_date"
  end

  test "should save task with valid attributes" do
    task = Task.new(name: "Task Name", project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today, due_date: Date.today + 1.month)
    assert task.save, "Failed to save the task with valid attributes"
  end

  test "should detect overdue task" do
    task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today - 2.months, due_date: Date.today - 1.month)
    assert task.overdue?, "Task was not detected as overdue"
  end

  test "should return 0 if task is overdue" do
    task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today - 2.months, due_date: Date.today - 1.month)
    assert_equal 0, task.how_many_days_before_due_date?, "Expected 0 for overdue task"
  end

  test "should return correct days if task is not overdue" do
    task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today, due_date: Date.today + 5.days)
    assert_equal 5, task.how_many_days_before_due_date?, "Expected 5 days before due date"
  end

  test "should return correct priority for LOW at 5 days" do
    task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today, due_date: Date.today + 5.days)
    assert_equal 0.2, task.priority, "Expected 0.2 for priority"
  end

  test "should return correct priority for MEDIUM at 5 days" do
    task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 5, start_date: Date.today, due_date: Date.today + 5.days)
    assert_equal 0.5, task.priority, "Expected 0.5 for priority"
  end

  test "should return correct priority for HIGH at 5 days" do
    task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 8, start_date: Date.today, due_date: Date.today + 5.days)
    assert_equal 0.8, task.priority, "Expected 0.8 for priority"
  end

  test "should not save task with criticity below 0" do
    task = Task.new(name: "Task Name", project: @project, user: @user, status: :new, start_date: Date.today, due_date: Date.today + 1.month, criticity: -1)
    assert_not task.save, "Saved the task with a criticity below 0"
  end

  test "should not save task with criticity above 10" do
    task = Task.new(name: "Task Name", project: @project, user: @user, status: :new, start_date: Date.today, due_date: Date.today + 1.month, criticity: 11)
    assert_not task.save, "Saved the task with a criticity above 10"
  end

  test "should save task with valid criticity" do
    task = Task.new(name: "Task Name", project: @project, user: @user, status: :new, start_date: Date.today, due_date: Date.today + 1.month, criticity: 5)
    assert task.save, "Failed to save the task with valid criticity"
  end
end
