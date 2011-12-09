class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # The Technology module handles accessing browsers and platforms
      #
      module Technology

        # Returns monthly browsers and platforms for a gauge
        #
        # date - String of date
        #
        # Returns json
        #
        def technology(date=nil)
          attributes = {}

          connection.get do |request|
            request.url "#{path_prefix}/technology"
            request.params['date'] = date if date && date.is_a?(String)
          end.body
        end
      end
    end
  end
end
