require 'spec_helper'

describe Twelve::API::Gauges::Locations do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#locations" do
    context "with no args" do
      it "should return locations" do
        VCR.use_cassette('locations') do
          response = subject.gauges(GAUGE_ID).locations
          response['date'].should_not be_nil
          response.should have_key('urls')

          locations = response['locations']
          locations.size.should > 0
          locations.first['title'].should_not be_nil
          locations.first['views'].should be_instance_of(Fixnum)
          locations.first['key'].should_not be_nil
        end
      end
    end

    context "with a date" do
      it "should return locations for that date" do
        VCR.use_cassette('locations("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).locations('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end
  end
end
