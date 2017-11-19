json.partial! 'api/shared/no_error'

json.(@task, :id, :name, :done, :project_id)
