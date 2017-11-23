json.partial! 'api/shared/error', model: @task

json.task do
  json.(@task, :id, :name, :done, :todo_on, :project_id)
end
