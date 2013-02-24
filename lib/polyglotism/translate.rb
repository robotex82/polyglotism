module Polyglotism
  module Translate
    def self.included(base)
      base.extend ClassMethods
    end # self.included(base)

    module ClassMethods
      def active_locale
        lambda { I18n.locale }
      end

      def translate *columns
        columns.each do |column|
          send :define_method, column do |*args|
            locale = args.first || I18n.locale

            return send("#{column}_#{locale}") if respond_to?("#{column}_#{locale}")
            send("#{column}_#{I18n.default_locale.to_s}")
          end

          send :define_method, "#{column}=" do |*args|
            value = args.first
            locale = args[1] || I18n.locale

            return send("#{column}_#{locale}=", value) if respond_to?("#{column}_#{locale}=")
            send("#{column}_#{I18n.default_locale.to_s}=", value)
          end
        end # each
      end # def translate
    end # ClassMethods
  end # module Translate
end # module Polyglotism

