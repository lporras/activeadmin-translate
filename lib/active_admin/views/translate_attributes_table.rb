module ActiveAdmin
  module Translate

    # Adds a builder method `translate_attributes_table_for` to build a
    # table with translations for a model that has been localized with
    # Globalize3.
    #
    class TranslateAttributesTable < ::ActiveAdmin::Views::AttributesTable

      builder_method :translate_attributes_table_for

      def row(attr, &block)
        ::I18n.available_locales.each_with_index do |locale, index|
          @table << tr do
            if index == 0
              th :rowspan => ::I18n.available_locales.length do
                header_content_for(attr)
              end
            end
            td do
              lang = "<strong>#{::I18n.t(locale, scope: 'active_admin.translate')}: </strong>".html_safe
              content = ::I18n.with_locale locale do
                content_for(resource, block || attr)
              end
              lang + content
            end
          end
        end
      end

      protected

      def default_id_for_prefix
        'attributes_table'
      end

      def default_class_name
        'attributes_table'
      end

    end
  end
end
