require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup do
    @user = users(:user_one)
  end

  describe "Should not save project..." do
    it "without a name" do
      # test "should not save project without name" do
      project = Project.new(description: "A description", user: @user)
      assert_not project.save, "Saved the project without a name"
    end

    it "without description" do
      project = Project.new(name: "Project Name", user: @user)
      assert_not project.save, "Saved the project without a description"
    end

    it "without user" do
      project = Project.new(name: "Project Name", description: "A description")
      assert_not project.save, "Saved the project without a user"
    end
  end

  describe "Should save project..." do
    it "with valid attributes" do
      project = Project.new(name: "Project Name", description: "A description", user: @user)
      assert project.save, "Failed to save the project with valid attributes"
    end
  end
end
