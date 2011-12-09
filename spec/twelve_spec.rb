# encoding: UTF-8
require 'spec_helper'

describe Twelve do
  it "should have a VERSION constant" do
    Twelve.const_defined?('VERSION').should be_true
  end

  describe "#initialize" do
    it "should set up a connection" do
      api = Twelve.new(ACCESS_TOKEN)
      api.connection.should be_instance_of(Twelve::Connection)
      api.connection.access_token.should == ACCESS_TOKEN
    end
  end
end