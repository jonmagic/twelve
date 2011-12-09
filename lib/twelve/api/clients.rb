class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Clients module handles API Clients on Gauges
    #
    module Clients

      # Clients::Proxy inherits from Twelve::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Twelve::ResourceProxy

        # Creates an API client
        #
        # attributes - Hash of attributes
        #
        # Returns json
        #
        def create(attributes)
          connection.post(path_prefix, attributes).body['client']
        end

        # Deletes an API client
        #
        # key - String of key
        #
        # Returns json
        #
        def destroy
          connection.delete(path_prefix).body['client']
        end

        # Get API clients
        #
        # Returns json
        #
        def subject
          @subject ||= connection.get(path_prefix).body['clients']
        end
      end

      # Get API clients
      #
      # Returns json
      #
      def clients(id=nil)
        path_prefix = id ? "/clients/#{id}" : '/clients'
        Proxy.new(connection, path_prefix)
      end
    end
  end
end