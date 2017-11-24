json.partial! 'api/shared/error', model: @pomodoro

json.pomodoro do
  json.(@pomodoro, :id, :box, :done, :task_id)
end
