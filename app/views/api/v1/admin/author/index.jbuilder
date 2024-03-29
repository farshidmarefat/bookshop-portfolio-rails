json.authors @authors do |author|
  author_hash = author.as_json.except("avatar")
  json.set! author.id do
    json.merge!(author_hash)
  end
end