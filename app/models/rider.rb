require 'sequel'

class Rider < Sequel::Model
  one_to_many :rides
end