json.translators @translators do |translator|
  translator_hash = translator.as_json.except("avatar")
  json.set! translator.id do
    json.merge!(translator_hash)
  end
end