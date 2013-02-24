require 'active_model/validations/validates'

module ActiveModel
  module Validations
    module ClassMethods
      def validates(*attributes)

        defaults = attributes.extract_options!.dup
        locales = defaults.delete(:locales)
        validations = defaults.slice!(*_validates_default_keys)

        raise ArgumentError, "You need to supply at least one attribute" if attributes.empty?
        raise ArgumentError, "You need to supply at least one validation" if validations.empty?

        defaults[:attributes] = attributes.dup
        defaults[:attributes].clear if defaults[:attributes].respond_to?(:size) && defaults[:attributes].size > 0

        if locales.nil?
          defaults[:attributes] = attributes
        else
          if locales == :all
            applied_locales = I18n.available_locales
          elsif locales.is_a?(Array) || locales.is_a?(Proc)
            applied_locales = locales.to_a.map(&:to_s)
          end

          attributes.each do |attribute|
            applied_locales.each do |locale|

              defaults[:attributes] << "#{attribute}_#{locale}"
            end
          end
        end

        validations.each do |key, options|
          next unless options
          key = "#{key.to_s.camelize}Validator"

          begin
            validator = key.include?('::') ? key.constantize : const_get(key)
          rescue NameError
            raise ArgumentError, "Unknown validator: '#{key}'"
          end

          validates_with(validator, defaults.merge(_parse_validates_options(options)))
        end
      end
    end
  end
end

