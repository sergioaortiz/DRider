require 'sequel'
require 'dotenv/load'

Sequel.postgres(host: ENV['HOST'], port: ENV['PORT'], user: ENV['USER'], password: ENV['PASSWORD'], database: ENV['DATABASE'])