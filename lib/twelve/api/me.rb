class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Me module handles your information on Gauges
    #
    module Me

      # Get and Update your information, accepts attributes
      #
      # attributes - Hash of attributes to update
      #
      # Returns json
      #
      def me(attributes=nil)
        response = if attributes
          connection.put('/me', attributes)
        else
          connection.get('/me')
        end

        response.body['user']
      end
    end
  end
end