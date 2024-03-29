json.translator do
  attributes = @translator.as_json.except("avatar")
  json.merge!(attributes)
end