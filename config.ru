require 'sinatra/base'

Dir.glob('./app/{config,controllers,providers,models,helpers}/*.rb').each { |file| require file } # Associate project files

map('/v1/rides') { run RideController } # Base path for endpoints