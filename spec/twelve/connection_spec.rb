require 'spec_helper'

describe Twelve::Connection do
  subject { Twelve::Connection.new(ACCESS_TOKEN) }

  describe "#initialize" do
    it "should set an instance variable for access token" do
      subject.access_token.should == ACCESS_TOKEN
    end
  end
end