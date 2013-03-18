# This file is used by Rack-based servers (in particular, Passenger) to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Valency::Application
