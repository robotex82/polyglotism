require 'active_record/connection_adapters/abstract/schema_definitions'

#module Polyglotism
#  module ActiveRecord
#    module ConnectionAdapters
#      module TablePatch
#        def self.included(base)
#          %w( string text integer float decimal datetime timestamp time date binary boolean ).each do |column_type|
#            base.class_eval <<-EOV, __FILE__, __LINE__ + 1
#              def #{column_type}(*args)                                          # def string(*args)
#                options = args.extract_options!                                  #   options = args.extract_options!
#                column_names = localized_column_names(args,                      #   column_names = localized_column_names(args,
#                                                      options.delete(:locales))  #                                         options.delete(:locales))
#                type = :'#{column_type}'                                         #   type = :string
#                column_names.each do |name|                                      #   column_names.each do |name|
#                  column = ColumnDefinition.new(@base, name.to_s, type)          #     column = ColumnDefinition.new(@base, name, type)
#                  if options[:limit]                                             #     if options[:limit]
#                    column.limit = options[:limit]                               #       column.limit = options[:limit]
#                  elsif native[type].is_a?(Hash)                                 #     elsif native[type].is_a?(Hash)
#                    column.limit = native[type][:limit]                          #       column.limit = native[type][:limit]
#                  end                                                            #     end
#                  column.precision = options[:precision]                         #     column.precision = options[:precision]
#                  column.scale = options[:scale]                                 #     column.scale = options[:scale]
#                  column.default = options[:default]                             #     column.default = options[:default]
#                  column.null = options[:null]                                   #     column.null = options[:null]
#                  @base.add_column(@table_name, name, column.sql_type, options)  #     @base.add_column(@table_name, name, column.sql_type, options)
#                end                                                              #   end
#              end                                                                # end
#            EOV
#          end
#        end
#      end
#    end
#  end
#end

# ::ActiveRecord::ConnectionAdapters::Table.class_eval { include Polyglotism::ActiveRecord::ConnectionAdapters::TablePatch }

#class << ActiveRecord::ConnectionAdapters::Table
#  include Polyglotism::ActiveRecord::ConnectionAdapters::TablePatch
#end

module ActiveRecord
  module ConnectionAdapters
    class Table
      %w( string text integer float decimal datetime timestamp time date binary boolean ).each do |column_type|
        class_eval <<-EOV, __FILE__, __LINE__ + 1
          def #{column_type}(*args)                                          # def string(*args)
            options = args.extract_options!                                  #   options = args.extract_options!
            column_names = localized_column_names(args,                      #   column_names = localized_column_names(args,
                                                  options.delete(:locales))  #                                         options.delete(:locales))
            type = :'#{column_type}'                                         #   type = :string
            column_names.each do |name|                                      #   column_names.each do |name|
              column = ColumnDefinition.new(@base, name.to_s, type)          #     column = ColumnDefinition.new(@base, name, type)
              if options[:limit]                                             #     if options[:limit]
                column.limit = options[:limit]                               #       column.limit = options[:limit]
              elsif native[type].is_a?(Hash)                                 #     elsif native[type].is_a?(Hash)
                column.limit = native[type][:limit]                          #       column.limit = native[type][:limit]
              end                                                            #     end
              column.precision = options[:precision]                         #     column.precision = options[:precision]
              column.scale = options[:scale]                                 #     column.scale = options[:scale]
              column.default = options[:default]                             #     column.default = options[:default]
              column.null = options[:null]                                   #     column.null = options[:null]
              @base.add_column(@table_name, name, column.sql_type, options)  #     @base.add_column(@table_name, name, column.sql_type, options)
            end                                                              #   end
          end                                                                # end
        EOV
      end
    end
  end
end

