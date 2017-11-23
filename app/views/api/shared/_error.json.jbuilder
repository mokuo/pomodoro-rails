if model.errors.present?
  json.error do
    json.code 402
    json.messages model.errors.full_messages
  end
else
  json.error do
    json.code 0
  end
end
