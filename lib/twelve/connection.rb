require 'faraday'
require 'faraday_middleware'
require 'multi_json'

class Twelve
  class Connection < Faraday::Connection
    attr_reader :access_token

    # Instantiates connection, requires an access_token
    #
    # access_token - String of the access token
    #
    def initialize(access_token=nil)
      @access_token = access_token

      super('https://secure.gaug.es') do |builder|
        builder.request   :url_encoded
        builder.use       Faraday::Response::ParseJson
        builder.adapter   Faraday.default_adapter
      end

      self.headers["X-Gauges-Token"] = "#{access_token}" if access_token
      self.headers["Accept"] = 'application/json'
    end
  end
end