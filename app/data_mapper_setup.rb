require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'
require_relative 'models/favourite'

env = ENV["RACK_ENV"] || "development"
# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'])

DataMapper.finalize
# DataMapper.auto_migrate!