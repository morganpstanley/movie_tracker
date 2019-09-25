require './config/environment'

use Rack::MethodOverride

use UsersController
use MoviesController
run ApplicationController