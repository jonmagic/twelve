require 'spec_helper'

describe Twelve::API::Clients do
  subject { Twelve.new(ACCESS_TOKEN) }

  def should_be_a_client(client)
    client['created_at'].should_not be_nil
    client['urls']['self'].should == "https://secure.gaug.es/clients/#{client['key']}"
    client.should have_key('description')
  end

  describe "#clients" do
    it "returns a list of your API clients" do
      VCR.use_cassette('clients') do
        clients = subject.clients
        clients.should be_instance_of(Array)
        clients.size.should > 0
        should_be_a_client(clients.first)
      end
    end

    describe "#create" do
      it "returns created client" do
        VCR.use_cassette('clients_create') do
          client = subject.clients.create(:description => "12 Gauge")
          should_be_a_client(client)
          # cleanup
          subject.clients(client['key']).destroy
        end
      end
    end

    describe "#destroy" do
      it "returns deleted client" do
        VCR.use_cassette('clients_delete') do
          delete = subject.clients.create(:description => "Testing Twelve")
          client = subject.clients(delete['key']).destroy
          should_be_a_client(client)
        end
      end
    end
  end
end
