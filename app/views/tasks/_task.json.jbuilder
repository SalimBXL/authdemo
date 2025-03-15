json.extract! task, :id, :name, :description, :remarks, :start_date, :due_date, :project_id, :level, :user_id, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
