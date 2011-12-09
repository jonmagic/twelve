require 'spec_helper'

describe Twelve::API::Gauges do
  subject { Twelve.new(ACCESS_TOKEN) }

  def should_be_a_gauge(gauge)
    gauge['id'].should_not be_nil
    gauge['title'].should_not be_nil
    gauge['tz'].should_not be_nil
    gauge['urls']['self'].should == "https://secure.gaug.es/gauges/#{gauge['id']}"
    gauge['urls']['referrers'].should == "https://secure.gaug.es/gauges/#{gauge['id']}/referrers"
    gauge['urls']['technology'].should == "https://secure.gaug.es/gauges/#{gauge['id']}/technology"
    gauge.should have_key('all_time')
    gauge.should have_key('today')
    gauge.should have_key('yesterday')
    gauge.should have_key('recent_hours')
    gauge.should have_key('recent_days')
    gauge.should have_key('recent_months')
  end

  describe "#gauges" do
    # will only pass if you already have a gauge created on your account
    context "without an id" do
      it "returns your gauges" do
        VCR.use_cassette('gauges') do
          # setup
          temp = subject.gauges.create({
            :title => 'Twelve Gauge',
            :tz => 'Eastern Time (US & Canada)'
          })

          # actually run the request and tests
          gauges = subject.gauges
          gauges.should be_instance_of(Array)
          gauges.size.should > 0
          should_be_a_gauge(gauges.first)

           # teardown
          subject.gauges(temp['id']).destroy
        end
      end

      describe "#create" do
        it "creates and returns gauge" do
          VCR.use_cassette('gauges_create') do
            gauge = subject.gauges.create({
              :title => 'Twelve Gauge',
              :tz => 'Eastern Time (US & Canada)'
            })
            should_be_a_gauge(gauge)
            gauge['title'].should == 'Twelve Gauge'

            # teardown
            subject.gauges(gauge['id']).destroy
          end
        end
      end
    end
    #
    context "with an id" do
      context "with attributes" do
        it "updates and returns the gauge" do
          VCR.use_cassette('gauges(id, attributes)') do
            # setup
            temp = subject.gauges.create({
              :title => 'Twelve Gauge',
              :tz => 'Eastern Time (US & Canada)'
            })

            gauge = subject.gauges(temp['id'], {
              :title => '12 Gauge'
            })
            should_be_a_gauge(gauge)
            gauge['title'].should == '12 Gauge'

             # teardown
            subject.gauges(temp['id']).destroy
          end
        end
      end

      context "without attributes" do
        it "returns a gauge" do
          VCR.use_cassette('gauges(id)') do
            # setup
            temp = subject.gauges.create({
              :title => 'Twelve Gauge',
              :tz => 'Eastern Time (US & Canada)'
            })

            # actually run the request and tests
            gauge = subject.gauges(temp['id'])
            should_be_a_gauge(gauge)
            gauge['title'].should == 'Twelve Gauge'

             # teardown
            subject.gauges(temp['id']).destroy
          end
        end

        describe "#delete" do
          it "deletes and returns gauge" do
            VCR.use_cassette('gauges_delete') do
              # setup
              delete = subject.gauges.create({
                :title => 'Twelve Gauge',
                :tz => 'Eastern Time (US & Canada)'
              })

              gauge = subject.gauges(delete['id']).destroy
              should_be_a_gauge(gauge)
              gauge['id'].should == delete['id']
            end
          end
        end
      end
    end
  end
end
