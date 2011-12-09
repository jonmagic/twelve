class Twelve

  # API module encapsulates all of the API endpoints
  #
  module API

    # The Gauges module handles Gauges on Gauges
    #
    module Gauges

      # The Shares module handles sharing gauges
      #
      module Shares

        # Get a list of users gauge is shared with
        #
        # Returns json
        #
        def shares
          connection.get("#{path_prefix}/shares").body['shares']
        end

        # Shares a gauge with a person by their email
        #
        # email - String of email address
        #
        # Returns json
        #
        def share(email)
          connection.post("#{path_prefix}/shares", email).body['share']
        end

        # Un-shares a gauge with a person by their email
        #
        # id - String of user id
        #
        # Returns json
        #
        def unshare(id)
          connection.delete("#{path_prefix}/shares/#{id}").body['share']
        end
      end
    end
  end
end