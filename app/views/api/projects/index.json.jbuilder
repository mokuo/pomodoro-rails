json.set! :error do
  json.set! :code, 0
end

json.projects @projects, :id, :name, :stopped_at
