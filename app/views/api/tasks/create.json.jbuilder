json.partial! 'api/shared/error', model: @task

json.(@task, :id, :name, :done, :project_id)
