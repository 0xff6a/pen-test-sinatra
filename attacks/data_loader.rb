require 'json'

module DataLoader

  def load_payload_from(filename)
    JSON.parse(File.read(filename))
  end

end