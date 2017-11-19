json.partial! 'api/shared/no_error'

json.projects @projects do |project|
  json.id project.id
  json.name project.name
  json.tasks project.tasks do |task|
    json.id task.id
    json.name task.name
    json.done task.done
    json.pomodoros task.pomodoros do |pomodoro|
      json.id pomodoro.id
      json.box pomodoro.box
      json.done pomodoro.done
    end
  end
end
