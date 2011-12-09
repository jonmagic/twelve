require 'spec_helper'

describe Twelve::API::Gauges::Technology do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#technology" do
    context "with no args" do
      it "should return top technology" do
        VCR.use_cassette('technology') do
          response = subject.gauges(GAUGE_ID).technology
          response['date'].should_not be_nil
          response.should have_key('urls')

          browsers = response['browsers']
          browsers.first['title'].should_not be_nil
          browsers.first['views'].should be_instance_of(Fixnum)
          browsers.first['versions'].size.should > 0
          browsers.first['key'].should_not be_nil
          platforms = response['platforms']
          platforms.first['title'].should_not be_nil
          platforms.first['views'].should be_instance_of(Fixnum)
          platforms.first['key'].should_not be_nil
        end
      end
    end

    context "with a date" do
      it "should return technology for that date" do
        VCR.use_cassette('technology("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).technology('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end
  end
end
