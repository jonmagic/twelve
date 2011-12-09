class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # The Resolutions module handles accessing screen resolutions
      #
      module Resolutions

        # Returns monthly screen sizes for a gauge
        #
        # date - String of date
        #
        # Returns json
        #
        def resolutions(date=nil)
          attributes = {}

          connection.get do |request|
            request.url "#{path_prefix}/resolutions"
            request.params['date'] = date if date && date.is_a?(String)
          end.body
        end
      end
    end
  end
end
