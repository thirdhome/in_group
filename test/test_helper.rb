# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "in_group"
require "uri"

database_url = ENV["DB"]
unless database_url
  abort("You must supply a supported database URL in the environment variable DB")
end
u = URI.parse(database_url)
connect_args =
  {
    adapter: u.scheme,
    host: u.host,
    username: u.user,
    password: u.password,
    database: u.path[1..],
    port: u.port
  }

ActiveRecord::Base.establish_connection connect_args

load File.dirname(__FILE__) + "/support/schema.rb"
require File.dirname(__FILE__) + "/support/user.rb"
load File.dirname(__FILE__) + "/support/seed.rb"

require "minitest/autorun"
