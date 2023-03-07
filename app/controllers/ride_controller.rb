require 'sinatra'
require 'sequel'
require 'active_support'

class RideController < Sinatra::Base

  put '/start-ride' do
    json = JSON.parse(request.body.read)
    
    if json["legal_id"].blank? || json["legal_id_type"].blank? || json["starting_latitude"].blank? || json["starting_longitude"].blank? then
      data = "{
        \"type\": \"INPUT_VALIDATION_ERROR\",
        \"reason\": \"Incomplete attributes\"
      }"
      response = JSON.parse(data)
      halt 422, {'Content-Type' => 'application/json'}, { error: response }.to_json
    else
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
  end

  put '/end-ride' do
    json = JSON.parse(request.body.read)

    if json["id_ride"].blank? || json["installments"].blank? || json["final_latitude"].blank? || json["final_longitude"].blank? then
      data = "{
        \"type\": \"INPUT_VALIDATION_ERROR\",
        \"reason\": \"Incomplete attributes\"
      }"
      response = JSON.parse(data)
      halt 422, {'Content-Type' => 'application/json'}, { error: response }.to_json
    else
      transaction = Transaction.where(id_ride: json["id_ride"]).first
      if transaction then
        data = "{
          \"type\": \"INPUT_VALIDATION_ERROR\",
          \"reason\": \"A transaction already exists for this ride\"
        }"
        response = JSON.parse(data)
        halt 422, {'Content-Type' => 'application/json'}, { error: response }.to_json
      else
        RideHelper.new().end_ride(json)
      end
    end
  end

end