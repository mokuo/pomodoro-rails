json.partial! 'api/shared/no_error'

json.projects @projects, :id, :name, :stopped_at
