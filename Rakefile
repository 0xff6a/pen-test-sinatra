require 'data_mapper'
require File.join(File.dirname(__FILE__), 'app/data_mapper_setup.rb')
require File.join(File.dirname(__FILE__), 'app/server.rb')

task :auto_upgrade do
	DataMapper.auto_upgrade!
	puts 'Auto-upgrade complete (no data loss)'
end

task :auto_migrate do
	DataMapper.auto_migrate!
	puts 'Auto-migrate complete (data could have been lost)'
end

task :seed do
  User.all.destroy
  User.create(:email => '1@2.com',
              :password => 'qwertyuiop',
              :password_confirmation => 'qwertyuiop')
  User.create(:email => 'me@me.com',
              :password => '12345678',
              :password_confirmation => '12345678')
  puts User.all.inspect
end