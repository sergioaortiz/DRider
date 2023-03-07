require 'sinatra'
require 'sequel'

class RideController < Sinatra::Base

  put '/start-ride' do
    json = JSON.parse(request.body.read)
    rider = Rider.where(legal_id: json["legal_id"], legal_id_type: json["legal_id_type"]).first
      
    if rider then
      RideHelper.new().start_ride(json, rider)
    else
      data = "{
        \"type\": \"NOT_FOUND_ERROR\",
        \"reason\": \"Customer doesn't exist\"
      }"
      response = JSON.parse(data)
      halt 404, {'Content-Type' => 'application/json'}, { error: response }.to_json
    end
  end

  put '/end-ride' do
    json = JSON.parse(request.body.read)
    RideHelper.new().end_ride(json)
  end

end