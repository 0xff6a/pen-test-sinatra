def parse(hash_string)
  hash = {}
  hash_string.split(',').each do |pair|
    key,value = pair.split(/:/)
    hash[key] = value
  end
  hash
end