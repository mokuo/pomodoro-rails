json.partial! 'api/shared/error', model: @task

json.set! :task do
  json.(@task, :id, :name, :done, :todo_on, :project_id)
end
