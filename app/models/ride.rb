require 'sequel'

class Ride < Sequel::Model
  one_to_one :transaction
  many_to_one :driver
  many_to_one :rider
end