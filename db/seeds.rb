# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Create some statuses
[ "New", "In Progress", "Done", "Delayed" ].each do |level|
    Level.find_or_create_by!(level: level)
end

# Create a default admin user
admin = User.find_or_create_by!(email_address: "admin@johnsproject.com") do |user|
    user.password = "password"
    user.password_confirmation = "password"
    user.admin = true
end

# Create a default user
user1 = User.find_or_create_by!(email_address: "john.vannamen@hubruxelles.be") do |user1|
    user1.password = "password"
    user1.password_confirmation = "password"
    user1.admin = false
    user1.firstname = "John"
    user1.lastname = "Vannamen"
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
    project.start_date = Date.today
    project.end_date = Date.today + 1.month
    project.user = user
end

# Create a default task
task = Task.find_or_create_by!(name: "Task 1") do |task|
    task.description = "This is a task"
    task.start_date = Date.today
    task.due_date = Date.today + 1.month
    task.project = project
    task.user = user1
    task.level = Level.find_by(level: "New")
end
