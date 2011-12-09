# encoding: UTF-8
require 'twelve/version'
require 'twelve/connection'
require 'twelve/resource_proxy'
require 'twelve/api/me'
require 'twelve/api/clients'
require 'twelve/api/gauges/shares'
require 'twelve/api/gauges/content'
require 'twelve/api/gauges/referrers'
require 'twelve/api/gauges/traffic'
require 'twelve/api/gauges/resolutions'
require 'twelve/api/gauges/technology'
require 'twelve/api/gauges/terms'
require 'twelve/api/gauges'

class Twelve
  attr_reader :connection

  include Twelve::API::Me
  include Twelve::API::Clients
  include Twelve::API::Gauges

  # Instantiates Twelve, requires an access_token
  #
  # Access_token - String of the access_token
  #
  def initialize(access_token=nil)
    @connection = Twelve::Connection.new(access_token)
  end
end