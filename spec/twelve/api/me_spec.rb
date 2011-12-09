require 'spec_helper'

describe Twelve::API::Me do
  subject { Twelve.new(ACCESS_TOKEN) }

  def should_be_me(me)
    me['urls']['self'].should == 'https://secure.gaug.es/me'
    me['urls']['gauges'].should == 'https://secure.gaug.es/gauges'
    me['urls']['clients'].should == 'https://secure.gaug.es/clients'
    me['id'].size.should == 24
    me['email'].should_not be_nil
  end

  describe "#me" do
    context "without an arguement" do
      it "returns my information" do
        VCR.use_cassette('me') do
          me = subject.me
          should_be_me(me)
        end
      end
    end

    context "with a hash" do
      it "updates my information" do
        VCR.use_cassette('me_with_hash') do
          me = subject.me(:first_name => 'Jon')
          should_be_me(me)
          me['first_name'].should == "Jon"
        end
      end
    end
  end
end
