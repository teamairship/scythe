module Scythe
  class Base
    attr_reader :request
    attr_reader :credentials

    def initialize(access_token: nil, bearer_token: nil, account_id: nil)
      api_token = access_token || bearer_token

      @credentials = if api_token && account_id
        Scythe::API::Credentials.new(api_token, account_id)
      else
        fail 'You must provide either :access_token and :account_id or a :bearer_token and :account_id'
      end
    end

    def clients
      @clients ||= Scythe::API::Clients.new(credentials)
    end
  end
end
