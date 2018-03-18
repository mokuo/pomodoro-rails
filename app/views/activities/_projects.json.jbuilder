json.array! projects do |project|
  json.id project.id
  json.name project.name
  json.is_default project.is_default
  json.tasks project.tasks.where(todo_on: nil) do |task|
    json.id task.id
    json.name task.name
    json.done task.done
  end
end
