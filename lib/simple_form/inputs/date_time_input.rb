module SimpleForm
  module Inputs
    class DateTimeInput < Base
      def input(context)
        if use_html5_inputs?
          @builder.send(:"#{input_type}_field", attribute_name, merged_input_options(context.options))
        else
          @builder.send(:"#{input_type}_select", attribute_name, input_options, merged_input_options(context.options))
        end
      end

      private

      def label_target
        position = case input_type
        when :date, :datetime
          date_order = input_options[:order] || I18n.t('date.order')
          date_order.first.to_sym
        else
          :hour
        end

        position = ActionView::Helpers::DateTimeSelector::POSITION[position]
        "#{attribute_name}_#{position}i"
      end

      def use_html5_inputs?
        input_options[:html5]
      end
    end
  end
end
