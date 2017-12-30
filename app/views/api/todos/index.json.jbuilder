json.partial! 'api/shared/no_error'

json.date @date

json.projects do
  json.partial! 'api/shared/projects', projects: @projects, date: @date
end
