json.authors @authors do |category|
  category_hash = category.as_json.except("icon")
  json.set! category.id do
    json.merge!(category_hash)
  end
end