# encoding: UTF-8
require 'twelve/version'
require 'twelve/connection'
require 'twelve/resource_proxy'

class Twelve
  attr_reader :connection

  # Instantiates Twelve, requires an access_token
  #
  # Access_token - String of the access_token
  #
  def initialize(access_token=nil)
    @connection = Twelve::Connection.new(access_token)
  end
end