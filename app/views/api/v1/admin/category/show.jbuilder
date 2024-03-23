json.category do
  attributes = @category.except("icon")
  json.merge!(attributes)
end