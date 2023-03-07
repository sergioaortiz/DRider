require 'sinatra/base'

Dir.glob('./app/{config,controllers,providers,models,helpers}/*.rb').each { |file| require file }

map('/v1/rides') { run RideController }