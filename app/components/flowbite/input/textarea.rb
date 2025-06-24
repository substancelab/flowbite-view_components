# frozen_string_literal: true

module Flowbite
  module Input
    class Textarea < Field
      class << self
        # rubocop:disable Layout/LineLength
        def styles
          {
            default: Flowbite::Style.new(
              default: ["block", "w-full", "text-gray-900", "bg-gray-50", "rounded-lg", "border", "border-gray-300", "focus:ring-blue-500", "focus:border-blue-500", "dark:bg-gray-700", "dark:border-gray-600", "dark:placeholder-gray-400", "dark:text-white", "dark:focus:ring-blue-500", "dark:focus:border-blue-500"],
              disabled: ["block", "w-full", "bg-gray-100", "rounded-lg", "border", "border-gray-300", "text-gray-900", "cursor-not-allowed"],
              error: ["block", "w-full", "bg-red-50", "border", "border-red-500", "text-red-900", "placeholder-red-700", "rounded-lg", "focus:ring-red-500", "focus:border-red-500", "dark:bg-gray-700", "dark:text-red-500", "dark:placeholder-red-500", "dark:border-red-500"]
            )
          }.freeze
        end
        # rubocop:enable Layout/LineLength
      end
      # Returns the HTML to use for the actual input field element.
      def call
        @form.send(
          input_field_type,
          @attribute,
          **options
        )
      end

      protected

      # Returns the CSS classes to apply to the input field
      def classes
        self.class.classes(size: size, state: state)
      end

      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :text_area
      end
    end
  end
end
