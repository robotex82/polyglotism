module Polyglotism
  module ActiveRecord
    module ConnectionAdapters
      class TableDefinitionColumnProxy
        def initialize(table_definition, locale)
          @table_definition = table_definition
          @locale = locale
        end

       %w( string text integer float decimal datetime timestamp time date binary boolean ).each do |column_type|
         class_eval <<-EOV, __FILE__, __LINE__ + 1
           def #{column_type}(*args)
            args[0] = "\#{args[0]}_\#{@locale}"
            return @table_definition.#{column_type}(*args)
           end
         EOV
       end
      end
    end
  end
end

