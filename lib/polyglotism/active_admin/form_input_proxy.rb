module Polyglotism
  module ActiveAdmin
    class FormInputProxy
      def initialize(form, locale)
        @form = form
        @locale = locale
      end

      def input(*args, &proc)
        args[0] = "#{args[0]}_#{@locale}"
        return @form.input(*args, &proc)
      end
    end
  end
end

