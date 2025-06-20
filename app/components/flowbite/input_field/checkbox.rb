# frozen_string_literal: true

module Flowbite
  class InputField
    class Checkbox < InputField
      protected

      def input_component
        ::Flowbite::Input::Checkbox
      end

      protected

      # Returns the HTML to use for the hint element if any
      def hint
        return unless hint?

        render(
          Flowbite::Input::Hint.new(
            @form,
            @attribute,
            hint_attributes: {
              class: "text-xs font-normal text-gray-500 dark:text-gray-300",
              id: id_for_hint_element
            },
            hint: @hint
          )
        )
      end

      # Returns the HTML to use for the label element
      def label
        render(
          Flowbite::Input::Label.new(
            @form,
            @attribute,
            label_attributes: {
              class: "font-medium text-gray-900 dark:text-gray-300"
            }
          )
        )
      end
    end
  end
end
