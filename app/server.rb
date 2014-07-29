require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'
require 'rack-flash'
require File.join(File.dirname(__FILE__), '..', 'lib/link.rb')
require File.join(File.dirname(__FILE__), '..', 'lib/tag.rb')
require File.join(File.dirname(__FILE__), '..', 'lib/user.rb')
require_relative 'helpers/application'
require_relative 'data_mapper_setup'
require_relative 'controllers/application.rb'
require_relative 'controllers/links.rb'
require_relative 'controllers/sessions.rb'
require_relative 'controllers/tags.rb'
require_relative 'controllers/users.rb'

enable :sessions
set :session_secret, 'supercalifragalisticexpialodocious'
use Rack::Flash












