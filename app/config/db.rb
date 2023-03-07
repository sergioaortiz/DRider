require 'sequel'
require 'dotenv/load'

Sequel.postgres(host: ENV['HOST'], user: ENV['USER'], password: ENV['PASSWORD'], database: ENV['DATABASE'])