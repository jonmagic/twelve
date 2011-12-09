require 'spec_helper'

describe Twelve::API::Gauges::Traffic do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#traffic" do
    context "with no args" do
      it "should return top traffic" do
        VCR.use_cassette('traffic') do
          response = subject.gauges(GAUGE_ID).traffic
          response['date'].should_not be_nil
          response.should have_key('urls')
          response['views'].should be_instance_of(Fixnum)
          response['people'].should be_instance_of(Fixnum)

          traffic = response['traffic']
          traffic.size.should > 0
          traffic.first['date'].should_not be_nil
          traffic.first['views'].should be_instance_of(Fixnum)
          traffic.first['people'].should be_instance_of(Fixnum)
        end
      end
    end

    context "with a date" do
      it "should return traffic for that date" do
        VCR.use_cassette('traffic("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).traffic('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end
  end
end
