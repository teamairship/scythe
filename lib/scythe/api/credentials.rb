module Scythe
  module API
    class Credentials
      def initialize(token, account_id)
        @access_token = token
        @account_id = account_id
      end

      def set_authentication(request_options)
        request_options[:headers] ||= {}
        request_options[:headers]["Authorization"] = "Bearer #{@access_token}"
        request_options[:headers]["Harvest-Account-Id"] = @account_id
      end

      def host
        "https://api.harvestapp.com/v2"
      end
    end
  end
end
