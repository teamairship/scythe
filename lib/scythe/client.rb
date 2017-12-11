module Scythe
  class Client < Hashie::Mash
    include Scythe::Concerns::Model

    api_path '/clients'
  end
end
