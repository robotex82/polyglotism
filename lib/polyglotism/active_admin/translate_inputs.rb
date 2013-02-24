module Polyglotism
  module ActiveAdmin
    class TranslateInputs
      def initialize(form_builder, *args, &proc)
        @form_builder = form_builder
        @args = args
        @proc = proc
        @index = build_index
      end

      def render
        @form_builder.form_buffers.last << "<div id=\"language-tabs-#{@index}\">".html_safe
        build_navigation()
        build_inputs()
        @form_builder.form_buffers.last << "</div>".html_safe
        build_javascript_tag()
      end

      private

      def build_navigation
        @form_builder.form_buffers.last << "<ul>".html_safe
        build_navigation_items
        @form_builder.form_buffers.last << "</ul>".html_safe
      end

      def build_navigation_items
        ::I18n.available_locales.each do |locale|
          build_navigation_item_for_locale(locale)
        end
      end

      def build_navigation_item_for_locale(locale)
          @form_builder.form_buffers.last << @form_builder.template.content_tag(:li,
                                              @form_builder.template.content_tag(:a,
                                                                      proc { ::I18n.t("languages.#{locale}") }.call,
                                                                        :href => "#lang-#{locale}-#{@index}"
                                                                       )   ).html_safe
      end

      def build_index
        "#{@form_builder.object.class.to_s.tableize.gsub('/', '-')}-#{@form_builder.object.object_id}"
      end

      def build_inputs
        ::I18n.available_locales.each do |locale|
          build_inputs_for_locale(locale)
        end
      end

      def build_inputs_for_locale(locale)
        @form_builder.form_buffers.last << "<div id=\"lang-#{locale}-#{@index}\">".html_safe
        p = FormInputProxy.new(@form_builder, locale)
        p.instance_eval(&@proc)
        @form_builder.form_buffers.last << "</div>".html_safe
      end

      def build_javascript_tag
        @form_builder.form_buffers.last << @form_builder.template.javascript_tag("$('#language-tabs-#{@index}').tabs();").html_safe
      end
    end
  end
end

