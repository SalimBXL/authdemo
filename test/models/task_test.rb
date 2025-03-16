require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_one)
    @project = projects(:project_one)
    @task = tasks(:task_one)
  end

  describe "Should not save a task ..." do
    it "without a name" do
      @task.name = nil
      assert_not @task.save, "Saved the task without a name"
    end

    it "without project" do
      @task.project = nil
      assert_not @task.save, "Saved the task without a project"
    end

    it "without user" do
      @task.user = nil
      assert_not @task.save, "Saved the task without a user"
    end

    it "if due_date is before start_date" do
      @task.start_date = Date.today
      @task.due_date = Date.yesterday
      assert_not @task.save, "Saved the task with a due_date before start_date"
    end
  end

  describe "Should save task..." do
    it "with valid attributes" do
      assert @task.save, "Failed to save the task with valid attributes"
    end
  end

  describe "Overdue tests..." do
    it "should detect overdue task" do
      @task.start_date = Date.today - 2.months
      @task.due_date = Date.today - 1.month
      assert @task.overdue?, "Task was not detected as overdue"
    end

    it "should return 0 if task is overdue" do
      @task.start_date = Date.today - 2.months
      @task.due_date = Date.today - 1.month
      assert_equal 0, @task.how_many_days_before_due_date?, "Expected 0 for overdue task"
    end

    it "should return correct days if task is not overdue" do
      @task.start_date = Date.today
      @task.due_date = Date.today + 5.days
      assert_equal 5, @task.how_many_days_before_due_date?, "Expected 5 days before due date"
    end
  end

  describe "Priority tests : should return correct priority..." do
    #   it "for LOW at 5 days" do
    #     task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 2, start_date: Date.today, due_date: Date.today + 5.days)
    #     assert_equal 0.2, task.priority, "Expected 0.2 for priority"
    #   end

    #   it "MEDIUM at 5 days" do
    #     task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 5, start_date: Date.today, due_date: Date.today + 5.days)
    #     assert_equal 0.5, task.priority, "Expected 0.5 for priority"
    #   end

    #   it "HIGH at 5 days" do
    #     task = Task.create!(name: "Task Name", project: @project, user: @user, status: :new, criticity: 8, start_date: Date.today, due_date: Date.today + 5.days)
    #     assert_equal 0.8, task.priority, "Expected 0.8 for priority"
    #   end
  end

  describe "Criticity tests..." do
    it "should not save task with criticity below 0" do
      @task.criticity = -1
      assert_not @task.save, "Saved the task with a criticity below 0"
    end

    it "should not save task with criticity above 10" do
      @task.criticity = 11
      assert_not @task.save, "Saved the task with a criticity above 10"
    end

    it "should save task with valid criticity" do
      @task.criticity = 5
      assert @task.save, "Failed to save the task with valid criticity"
      @task.criticity = 8
      assert @task.save, "Failed to save the task with valid criticity"
    end

    it "should set level at LOW if criticity is not well define" do
      @task.criticity = nil
      @task.set_level_from_criticity
      assert_equal "low", @task.level
    end
  end
end
