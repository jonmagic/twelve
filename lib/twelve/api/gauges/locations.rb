class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # The Locations module handles accessing locations
      #
      module Locations

        # Returns monthly locations for a gauge
        #
        # date - String of date
        #
        # Returns json
        #
        def locations(date=nil)
          attributes = {}

          connection.get do |request|
            request.url "#{path_prefix}/locations"
            request.params['date'] = date if date && date.is_a?(String)
          end.body
        end
      end
    end
  end
end
