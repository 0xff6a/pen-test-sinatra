env = ENV["RACK_ENV"] || "development"
# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!