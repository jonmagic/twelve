require 'spec_helper'

describe Twelve::API::Gauges::Resolutions do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#resolutions" do
    context "with no args" do
      it "should return top resolutions" do
        VCR.use_cassette('resolutions') do
          response = subject.gauges(GAUGE_ID).resolutions
          response['date'].should_not be_nil
          response.should have_key('urls')

          browser_heights = response['browser_heights']
          browser_heights.first['title'].should_not be_nil
          browser_heights.first['views'].should be_instance_of(Fixnum)
          browser_widths = response['browser_widths']
          browser_widths.first['title'].should_not be_nil
          browser_widths.first['views'].should be_instance_of(Fixnum)
          screen_widths = response['screen_widths']
          screen_widths.first['title'].should_not be_nil
          screen_widths.first['views'].should be_instance_of(Fixnum)
        end
      end
    end

    context "with a date" do
      it "should return resolutions for that date" do
        VCR.use_cassette('resolutions("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).resolutions('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end
  end
end
