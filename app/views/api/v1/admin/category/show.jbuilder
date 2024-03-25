json.category do
  attributes = @category.as_json.except("icon")
  json.merge!(attributes)
end