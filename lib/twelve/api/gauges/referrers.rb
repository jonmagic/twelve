class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # The Referrers module handles referrers
      #
      module Referrers

        # Returns top content for a gauge
        #
        # *args - Date string & options hash
        #
        # Returns json
        #
        def referrers(*args)
          attributes = {}

          connection.get do |request|
            request.url "#{path_prefix}/referrers"

            args.each do |arg|
              request.params['page'] = arg[:page].to_s if arg.is_a?(Hash) && arg.has_key?(:page)
              request.params['date'] = arg if arg.is_a?(String)
            end
          end.body
        end
      end
    end
  end
end
