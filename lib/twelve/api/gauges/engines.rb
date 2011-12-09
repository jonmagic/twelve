class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # The Engines module handles accessing search engines
      #
      module Engines

        # Returns monthly engines for a gauge
        #
        # date - String of date
        #
        # Returns json
        #
        def engines(date=nil)
          attributes = {}

          connection.get do |request|
            request.url "#{path_prefix}/engines"
            request.params['date'] = date if date && date.is_a?(String)
          end.body
        end
      end
    end
  end
end
