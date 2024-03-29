json.publisher do
  attributes = @publisher.as_json.except("logo")
  json.merge!(attributes)
end