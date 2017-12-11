module Scythe
  module API
    class Clients < Base
      include Scythe::Behaviors::Crudify

      api_model Scythe::Client
    end
  end
end
