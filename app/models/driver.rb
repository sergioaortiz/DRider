require 'sequel'

class Driver < Sequel::Model
  one_to_many :rides
end