require 'sinatra'
require "uri"
require "net/http"
require 'dotenv/load'

class WompiProvider
    attr_reader :private_key, :public_key, :acceptance_token, :payment_source_id, :redirect_url
  
    def initialize(private_key, public_key, acceptance_token, payment_source_id, redirect_url)
        @private_key = private_key
        @public_key = public_key
        @acceptance_token = acceptance_token
        @payment_source_id = payment_source_id
        @redirect_url = redirect_url
    end
  
    # Make the transaction using Wompi API
    def create_transaction(amount_in_cents, currency, customer_email, installments, reference, phone_number, full_name, legal_id, legal_id_type)
        url = URI("#{ENV['WOMPI_URL']}/transactions")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
      
        request = Net::HTTP::Post.new(url)
        request["Authorization"] = "Bearer #{private_key}"
        request["Content-Type"] = "application/json"
        request.body = "{
          \"acceptance_token\": \"#{acceptance_token}\",
          \"amount_in_cents\": #{amount_in_cents},
          \"currency\": \"#{currency}\",
          \"customer_email\": \"#{customer_email}\",
          \"payment_method\": {
            \"installments\": #{installments}
          },
          \"payment_source_id\": #{payment_source_id},
          \"redirect_url\": \"#{redirect_url}\",
          \"reference\": \"#{reference}\",
          \"customer_data\": {
            \"phone_number\": \"#{phone_number}\",
            \"full_name\": \"#{full_name}\",
            \"legal_id\": \"#{legal_id}\",
            \"legal_id_type\": \"#{legal_id_type}\"
          }
        }"
      
        response = https.request(request)
        response.read_body
    end
  end