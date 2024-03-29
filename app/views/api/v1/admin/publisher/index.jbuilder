json.publishers @publishers do |publisher|
  publisher_hash = publisher.as_json.except("logo")
  json.set! publisher.id do
    json.merge!(publisher_hash)
  end
end
