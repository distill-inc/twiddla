require 'net/http'
require 'twiddla/api'

module Twiddla
  def self.auth!(username, password)
    API.password = password
    API.username = username
  end
end
