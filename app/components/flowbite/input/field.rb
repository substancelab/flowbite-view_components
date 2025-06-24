# frozen_string_literal: true

module Flowbite
  module Input
    # The indivdual input component for use in forms without labels or error
    # messages.
    #
    # To render a complete input field with labels and error messages, use
    # `Flowbite::InputField` instead.
    class Field < ViewComponent::Base
      SIZES = {
        sm: ["p-2", "text-xs"],
        default: ["p-2.5", "text-sm"],
        lg: ["p-4", "text-base"]
      }.freeze

      STATES = [
        DEFAULT = :default,
        DISABLED = :disabled,
        ERROR = :error
      ].freeze

      attr_reader :input_attributes, :size, :style

      class << self
        def classes(size: :default, state: :default, style: :default)
          style = styles.fetch(style)
          state_classes = style.fetch(state)
          state_classes + sizes.fetch(size)
        end

        # Returns the sizes this Field supports.
        #
        # This is effectively the SIZES constant, but provided as a method to
        # return the constant from the current class, not the superclass.
        #
        # @return [Hash] A hash mapping size names to their corresponding CSS
        # classes.
        def sizes
          const_get(:SIZES)
        end

        # rubocop:disable Layout/LineLength
        def styles
          {
            default: Flowbite::Style.new(
              default: ["bg-gray-50", "border", "border-gray-300", "text-gray-900", "rounded-lg", "focus:ring-blue-500", "focus:border-blue-500", "block", "w-full", "dark:bg-gray-700", "dark:border-gray-600", "dark:placeholder-gray-400", "dark:text-white", "dark:focus:ring-blue-500", "dark:focus:border-blue-500"],
              disabled: ["bg-gray-100", "border", "border-gray-300", "text-gray-900", "text-sm", "rounded-lg", "focus:ring-blue-500", "focus:border-blue-500", "block", "w-full", "p-2.5", "cursor-not-allowed", "dark:bg-gray-700", "dark:border-gray-600", "dark:placeholder-gray-400", "dark:text-gray-400", "dark:focus:ring-blue-500", "dark:focus:border-blue-500"],
              error: ["bg-red-50", "border", "border-red-500", "text-red-900", "placeholder-red-700", "rounded-lg", "focus:ring-red-500", "dark:bg-gray-700", "focus:border-red-500", "block", "w-full", "dark:text-red-500", "dark:placeholder-red-500", "dark:border-red-500"]
            )
          }.freeze
        end
        # rubocop:enable Layout/LineLength
      end

      def initialize(form, attribute, disabled: false, input_attributes: {}, size: :default)
        super
        @attribute = attribute
        @disabled = disabled
        @form = form
        @input_attributes = input_attributes
        @object = form.object
        @size = size
      end

      # Returns the HTML to use for the actual input field element.
      def call
        @form.send(
          input_field_type,
          @attribute,
          **options
        )
      end

      # Returns the CSS classes to apply to the input field
      def classes
        self.class.classes(size: size, state: state)
      end

      # Returns the name of the method used to generate HTML for the input field
      def input_field_type
        :text_field
      end

      protected

      # Returns true if the field is disabled
      def disabled?
        !!@disabled
      end

      def errors?
        @object.errors.include?(@attribute.intern)
      end

      # Returns the options argument for the input field
      def options
        {
          class: classes,
          disabled: disabled?
        }.merge(input_attributes)
      end

      private

      def state
        return DISABLED if disabled?
        return ERROR if errors?

        DEFAULT
      end
    end
  end
end
