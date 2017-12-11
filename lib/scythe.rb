require 'httparty'
require 'delegate'
require 'json'
require 'time'
require 'hashie'

require 'extensions/array'

require 'scythe/version'
require 'scythe/errors'
require 'scythe/base'

%w[model].each { |a| require "scythe/concerns/#{a}" }
%w[client].each { |a| require "scythe/#{a}" }
%w[base clients credentials].each { |a| require "scythe/api/#{a}" }

module Scythe
  def self.client(access_token: nil, bearer_token: nil, account_id: nil)
    Scythe::Base.new(
      access_token: access_token,
      bearer_token: bearer_token,
      account_id: account_id
    )
  end
end
