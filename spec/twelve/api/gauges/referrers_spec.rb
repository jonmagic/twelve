require 'spec_helper'

describe Twelve::API::Gauges::Referrers do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#referrers" do
    context "with no args" do
      it "should return todays referrers" do
        VCR.use_cassette('referrers') do
          response = subject.gauges(GAUGE_ID).referrers
          response['date'].should_not be_nil
          response['page'].should == 1
          response['per_page'].should == 50
          response.should have_key('urls')

          referrers = response['referrers']
          referrers.size.should > 0
          referrers.first['url'].should_not be_nil
          referrers.first['views'].should be_instance_of(Fixnum)
          referrers.first['path'].should_not be_nil
          referrers.first['host'].should_not be_nil
        end
      end
    end

    context "with page number" do
      it "should return content for page" do
        VCR.use_cassette('referrers(:page => 2)') do
          response = subject.gauges(GAUGE_ID).referrers(:page => 2)
          response['page'].should == 2
        end
      end
    end

    context "with a date" do
      it "should return content for that date" do
        VCR.use_cassette('referrers("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).referrers('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end

    context "with a date and page" do
      it "should return content for that date" do
        VCR.use_cassette('referrers("2011-12-8", :page => 2)') do
          response = subject.gauges(GAUGE_ID).referrers('2011-12-8', :page => 2)
          response['date'].should == '2011-12-08'
          response['page'].should == 2
        end
      end
    end
  end
end
