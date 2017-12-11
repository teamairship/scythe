module Scythe
  module Concerns
    module Model
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend, ClassMethods
      end

      module InstanceMethods
        def to_i
          id
        end
      end

      module ClassMethods
        def api_path(path = nil)
          @_api_path ||= path
        end

        def parse(json, collection: false)
          parsed = String == json ? JSON.parse(json) : json
          models = collection ? parsed[json_root] : parsed
          Array.wrap(models).map { |attrs| new(attrs) }
        end

        def json_root
          Scythe::Concerns::Model::Utility.underscore(
            Scythe::Concerns::Model::Utility.demodulize(to_s)
          ).pluralize
        end
      end

      module Utility
        class << self

          # Both methods are shamelessly ripped from https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/inflections.rb

          # Removes the module part from the expression in the string.
          #
          # Examples:
          #   "ActiveRecord::CoreExtensions::String::Inflections".demodulize # => "Inflections"
          #   "Inflections".demodulize
          def demodulize(class_name_in_module)
            class_name_in_module.to_s.gsub(/^.*::/, '')
          end

          # Makes an underscored, lowercase form from the expression in the string.
          #
          # Changes '::' to '/' to convert namespaces to paths.
          #
          # Examples:
          #   "ActiveRecord".underscore         # => "active_record"
          #   "ActiveRecord::Errors".underscore # => active_record/errors
          #
          # As a rule of thumb you can think of +underscore+ as the inverse of +camelize+,
          # though there are cases where that does not hold:
          #
          #   "SSLError".underscore.camelize # => "SslError"
          def underscore(camel_cased_word)
            word = camel_cased_word.to_s.dup
            word.gsub!(/::/, '/')
            word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
            word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
            word.tr!('-', '_')
            word.downcase!
            word
          end
        end
      end
    end
  end
end
