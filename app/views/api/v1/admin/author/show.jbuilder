json.author do
  attributes = @author.as_json.except("avatar")
  json.merge!(attributes)
end