json.partial! 'api/shared/no_error'

json.projects do
  json.partial! 'api/shared/projects', projects: @projects, date: @date
end
