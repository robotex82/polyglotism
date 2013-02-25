module Polyglotism
  module ActiveRecord
    module ConnectionAdapters
      class ColumnTranslator
        def initialize(table_definition, *args, &proc)
          @table_definition = table_definition
          @args = args
          @proc = proc
        end

        def migrate
          build_columns
        end
        
        private
        
        def build_columns
          ::I18n.available_locales.each do |locale|
            build_columns_for_locale(locale)
          end
        end

        def build_columns_for_locale(locale)
          t = TableDefinitionColumnProxy.new(@table_definition, locale)
          t.instance_eval(&@proc)
        end
      end
    end
  end
end
