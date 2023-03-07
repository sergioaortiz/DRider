require 'dotenv/load'
require 'geokit'
require 'securerandom'

class RideHelper
  attr_reader :provider

  def initialize()
    @provider = WompiProvider.new(ENV['PRIVATE_KEY'], ENV['PUBLIC_KEY'], ENV['ACCEPTANCE_TOKEN'], ENV['PAYMENT_SOURCE_ID'], ENV['REDIRECT_URL'])
  end

  def start_ride(request, rider)
    # Find the nearest driver
    driver = Driver.order(Sequel.lit("SQRT(POW(69.1 * (latitude::float - #{request["starting_latitude"]}), 2) + POW(69.1 * (#{request["starting_longitude"]} - longitude::float) * COS(latitude::float / 57.3), 2))")).first

    # Create a new ride
    ride = Ride.new
    ride.id_driver = driver.id
    ride.id_rider = rider.id
    ride.starting_time = Time.now
    ride.starting_latitude = request["starting_latitude"]
    ride.starting_longitude = request["starting_longitude"]
    ride.save

    # Returns the ride id
    data = "{
      \"data\": {
        \"id_ride\": \"#{ride.id}\"
      }
    }"
    response = JSON.parse(data)
    response.to_json
  end

  def end_ride(request)
    # Search for the ride and update its arrival time
    ride = Ride.where(id: request["id_ride"]).first
    ride.update(final_time: Time.now)

    final_distance = distance(ride.starting_latitude, ride.starting_longitude, request["final_latitude"], request["final_longitude"]) # Calculate distance between start and final location
    minutes = ((ride.final_time - ride.starting_time) / 60).to_i # Calculate elapsed time in minutes
    amount = ((final_distance * 100000) + (minutes * 20000) + 350000).to_i # Calculate total amount to be paid
    ride.update(final_latitude: request["final_latitude"], final_longitude: request["final_longitude"])

    rider = Rider.where(id: ride.id_rider).first
    reference = SecureRandom.alphanumeric(32) # Generate reference code

    # Send data to transaction provider
    wompi_transaction = @provider.create_transaction(
      amount,
      "COP",
      rider.email,
      request["installments"],
      reference,
      rider.phone_number,
      rider.name,
      rider.legal_id,
      rider.legal_id_type
    )

    # Create transaction
    transaction = Transaction.new
    transaction.id_ride = request["id_ride"]
    transaction.reference = reference
    transaction.amount = amount
    transaction.created_at = Time.now
    transaction.save

    # Return the response from transaction provider
    wompi_transaction
  end

  # Method to calculate geographic distance
  def distance(starting_latitude, starting_longitude, final_latitude, final_longitude)
    starting = Geokit::LatLng.new(starting_latitude, starting_longitude)
    starting.distance_to([final_latitude, final_longitude]) * 1.609344
  end
end