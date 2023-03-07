require 'sequel'

class Transaction < Sequel::Model
  one_to_one :ride
end