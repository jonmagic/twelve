require 'spec_helper'

describe Twelve::API::Gauges::Shares do
  subject { Twelve.new(ACCESS_TOKEN) }

  def should_be_a_share(gauge, share)
    share['name'].should_not be_nil
    share['id'].should_not be_nil
    ['user', 'invite'].should include(share['type'])
    share['email'].should_not be_nil
    share['urls']['remove'].should == "https://secure.gaug.es/gauges/#{gauge['id']}/shares/#{share['id']}"
  end

  describe "#shares" do
    it "returns list of users gauge is shared with" do
      VCR.use_cassette('shares') do
        # setup
        temp = subject.gauges.create({
          :title => 'Twelve Gauge',
          :tz => 'Eastern Time (US & Canada)'
        })
        subject.gauges(temp['id']).share({:email => 'john@doe.com'})

        # the meat of the test
        shares = subject.gauges(temp['id']).shares
        shares.size.should > 0
        should_be_a_share(temp, shares.first)

        # teardown
        subject.gauges(temp['id']).destroy
      end
    end
  end

  describe "#share" do
    it "shares gauge" do
      VCR.use_cassette('share') do
        # setup
        temp = subject.gauges.create({
          :title => 'Twelve Gauge',
          :tz => 'Eastern Time (US & Canada)'
        })

        # the meat of the test
        share = subject.gauges(temp['id']).share({:email => 'john@doe.com'})
        should_be_a_share(temp, share)
        share['email'].should == 'john@doe.com'

        # teardown
        subject.gauges(temp['id']).destroy
      end
    end
  end

  describe "#unshare" do
    it "un-shares a gauge" do
      VCR.use_cassette('unshare') do
        # setup
        temp = subject.gauges.create({
          :title => 'Twelve Gauge',
          :tz => 'Eastern Time (US & Canada)'
        })
        temp_share = subject.gauges(temp['id']).share({:email => 'john@doe.com'})

        # the meat of the test
        share = subject.gauges(temp['id']).unshare(temp_share['id'])
        share['id'].should == temp_share['id']

        # teardown
        subject.gauges(temp['id']).destroy
      end
    end
  end
end
