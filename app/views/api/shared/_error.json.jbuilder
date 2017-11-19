if model.errors.present?
  json.set! :error do
    json.set! :code, 402
    json.set! :messages, model.errors.full_messages
  end
else
  json.set! :error do
    json.set! :code, 0
  end
end
