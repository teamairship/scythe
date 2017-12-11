module Scythe
  module Behaviors
    module Crudify
      def all(params = {})
        response = request(:get, credentials, api_model.api_path, query: params)
        parse_the(response.parsed_response, collection: true)
      end

      def find(id)
        raise 'id required' unless id
        response = request(:get, credentials, "#{api_model.api_path}/#{id}")
        parse_th(response.parsed_response).first
      end

      def parse_the(response, collection: false)
        api_model.parse(response.parsed_response, collection)
      end
    end
  end
end
