require 'spec_helper'

describe Twelve::API::Gauges::Content do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#content" do
    context "with no args" do
      it "should return top content" do
        VCR.use_cassette('content') do
          response = subject.gauges(GAUGE_ID).content
          response['date'].should_not be_nil
          response['page'].should == 1
          response['per_page'].should == 50
          response.should have_key('urls')

          content = response['content']
          content.size.should > 0
          content.first['title'].should_not be_nil
          content.first['views'].should be_instance_of(Fixnum)
          content.first['path'].should_not be_nil
          content.first['host'].should_not be_nil
        end
      end
    end

    context "with page number" do
      it "should return content for page" do
        VCR.use_cassette('content(:page => 2)') do
          response = subject.gauges(GAUGE_ID).content(:page => 2)
          response['page'].should == 2
        end
      end
    end

    context "with a date" do
      it "should return content for that date" do
        VCR.use_cassette('content("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).content('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end

    context "with a date and page" do
      it "should return content for that date" do
        VCR.use_cassette('content("2011-12-8", :page => 2)') do
          response = subject.gauges(GAUGE_ID).content('2011-12-8', :page => 2)
          response['date'].should == '2011-12-08'
          response['page'].should == 2
        end
      end
    end
  end
end
