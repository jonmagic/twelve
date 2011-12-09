class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # The Traffic module handles accessing traffic
      #
      module Traffic

        # Returns monthly traffic for a gauge
        #
        # date - String of date
        #
        # Returns json
        #
        def traffic(date=nil)
          attributes = {}

          connection.get do |request|
            request.url "#{path_prefix}/traffic"
            request.params['date'] = date if date && date.is_a?(String)
          end.body
        end
      end
    end
  end
end
