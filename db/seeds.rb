# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create a default admin user
admin = User.find_or_create_by!(email_address: "admin@johnsproject.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.admin = true
end

# Create a default user
john = User.find_or_create_by!(email_address: "john.vannamen@hubruxelles.be") do |john|
  john.password = "password"
  john.password_confirmation = "password"
  john.admin = false
  john.firstname = "John"
  john.lastname = "Vannamen"
end

user = User.find_or_create_by!(email_address: "el.salim.salim@gmail.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.admin = false
  user.firstname = "Salim"
  user.lastname = "JOLY"
end

# Create a default project
project = Project.find_or_create_by!(name: "Project 1") do |project|
  project.description = "This is a project"
  project.user = user
end

# Create a default task
task = Task.find_or_create_by!(
  name: "Task 1",
  project: project,
  user: john,
  level: :low,
  status: :new,
  start_date: Date.today,
  due_date: Date.today + 1.month
) do |task|
  task.description = "This is a task"
  task.remarks = "This is a remark"
end
