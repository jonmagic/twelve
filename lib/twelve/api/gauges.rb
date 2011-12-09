class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # Gauges::Proxy inherits from Twelve::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Twelve::ResourceProxy
        include Twelve::API::Gauges::Content
        include Twelve::API::Gauges::Shares

        # Creates a gauge
        #
        # attributes - Hash of attributes
        #
        # Returns json
        #
        def create(attributes)
          connection.post(path_prefix, attributes).body['gauge']
        end

        # Deletes a gauge
        #
        # Returns json
        #
        def destroy
          connection.delete(path_prefix).body['gauge']
        end

        # Get gauges, gauge, or update gauge
        #
        # Returns json
        #
        def subject
          response = if attributes
            connection.put(path_prefix, attributes).body
          else
            connection.get(path_prefix).body
          end
          @subject ||= path_prefix == '/gauges' ? response['gauges'] : response['gauge']
        end
      end

      # Get, Create, Update, and Delete Gauges
      #
      # Returns json
      #
      def gauges(id=nil, attributes=nil)
        path_prefix = id ? "/gauges/#{id}" : '/gauges'
        Proxy.new(connection, path_prefix, attributes)
      end
    end
  end
end