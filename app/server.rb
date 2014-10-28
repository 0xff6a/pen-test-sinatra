require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'
require 'rack-flash'
require 'rest-client'

require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'
require_relative 'models/mailer'
require_relative 'models/favourite'
require_relative 'helpers/application'
require_relative 'helpers/links'
require_relative 'helpers/users'
require_relative 'data_mapper_setup'

require_relative 'controllers/application.rb'
require_relative 'controllers/links.rb'
require_relative 'controllers/sessions.rb'
require_relative 'controllers/tags.rb'
require_relative 'controllers/users.rb'
require_relative 'controllers/favourites.rb'

enable :sessions
set :session_secret, 'supercalifragalisticexpialodocious'
use Rack::Flash
set :partial_template_engine, :erb











