require 'spec_helper'

describe Twelve::API::Gauges::Terms do
  subject { Twelve.new(ACCESS_TOKEN) }

  describe "#terms" do
    context "with no args" do
      it "should return search terms" do
        VCR.use_cassette('terms') do
          response = subject.gauges(GAUGE_ID).terms
          response['date'].should_not be_nil
          response['page'].should == 1
          response['per_page'].should == 50
          response.should have_key('urls')

          terms = response['terms']
          terms.size.should > 0
          terms.first['term'].should_not be_nil
          terms.first['views'].should be_instance_of(Fixnum)
        end
      end
    end

    context "with page number" do
      it "should return terms for page" do
        VCR.use_cassette('terms(:page => 2)') do
          response = subject.gauges(GAUGE_ID).terms(:page => 2)
          response['page'].should == 2
        end
      end
    end

    context "with a date" do
      it "should return terms for that date" do
        VCR.use_cassette('terms("2011-12-8")') do
          response = subject.gauges(GAUGE_ID).terms('2011-12-8')
          response['date'].should == '2011-12-08'
        end
      end
    end

    context "with a date and page" do
      it "should return terms for that date" do
        VCR.use_cassette('terms("2011-12-8", :page => 2)') do
          response = subject.gauges(GAUGE_ID).terms('2011-12-8', :page => 2)
          response['date'].should == '2011-12-08'
          response['page'].should == 2
        end
      end
    end
  end
end
