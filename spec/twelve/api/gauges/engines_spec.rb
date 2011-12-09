require 'spec_helper'

describe Twelve::API::Gauges::Engines do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#engines" do
    context "with no args" do
      it "should return search engines" do
        VCR.use_cassette('engines') do
          response = subject.gauges(GAUGE_ID).engines
          response['date'].should_not be_nil
          response.should have_key('urls')

          engines = response['engines']
          engines.size.should > 0
          engines.first['title'].should_not be_nil
          engines.first['views'].should be_instance_of(Fixnum)
          engines.first['key'].should_not be_nil
        end
      end
    end

    context "with a date" do
      it "should return engines for that date" do
        VCR.use_cassette('engines("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).engines('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end
  end
end
