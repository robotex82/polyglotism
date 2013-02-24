require 'polyglotism/engine'
require 'polyglotism/translate'
require 'polyglotism/active_admin/form_builder_patch'
require 'polyglotism/active_admin/form_input_proxy'
require 'polyglotism/active_admin/translate_inputs'
require 'polyglotism/active_model/validations_patch'
# require 'polyglotism/active_record/connection_adapters/abstract/schema_definitions_patch'
require 'jquery-ui-rails'

module Polyglotism
end

ActiveRecord::Base.send :include, Polyglotism::Translate
