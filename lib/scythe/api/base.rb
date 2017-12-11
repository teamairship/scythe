module Scythe
  module API
    class Base
      attr_reader :credentials

      def initialize(credentials)
        @credentials = credentials
      end

      class << self
        def api_model(klass)
          class_eval <<-CE
            def api_model
              #{klass}
            end
          CE
        end

        def api_path(path)
          class_eval <<-CE
            def api_path
              #{path}
            end
          CE
        end
      end

      protected

      def request(method, credentials, path, request_options = {})
        params = {
          path: path,
          options: request_options,
          method: method
        }

        options = {
          body: request_options[:body],
          query: request_options[:query],
          format: :plain,
          headers: {
            'Accept'       => 'application/json',
            'Content-Type' => 'application/json; charset=utf-8',
            'User-Agent'   => "Scythe/#{Scythe::VERSION}"
          }.update(request_options[:headers] || {})
        }

        update_the(credentials, options)

        response = HTTParty.send(
          method,
          "#{credentials.host}#{path}",
          options
        )

        handle_the(response, params)
      end

      def update_the(credentials, httparty_options)
        credentials.set_authentication(httparty_options)
      end

      def handle_the(response, params)
        params[:response] = response.inspect.to_s

        case response.code
        when 200..201
          response
        when HTTPError.list.keys.include?(response.code)
          HTTPError.list[response.code].new(response, params)
        else
          raise Scythe::InformHarvest.new(response, params)
        end
      end
    end
  end
end
