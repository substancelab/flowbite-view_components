# frozen_string_literal: true

module Flowbite
  # A form element for a single field, containing label, input field, error
  # messages, helper text and whatever else is needed for a user friendly input
  # experience.
  #
  # @see https://flowbite.com/docs/forms/input-field/
  #
  # The input field is an important part of the form element that can be used to
  # create interactive controls to accept data from the user based on multiple
  # input types, such as text, email, number, password, URL, phone number, and
  # more.
  #
  # Usually you'd use one of the subclasses of this class which implement the
  # different input types, like `Flowbite::InputField::Text`,
  # `Flowbite::InputField::Email`, etc.
  #
  # Expects 2 arguments:
  #
  # @param attribute [Symbol] The name of the attribute to render in this input
  # field.
  #
  # @param form [ActionView::Helpers::FormBuilder] The form builder object that
  # will be used to generate the input field.
  #
  # Supports additional arguments:
  #
  # @param hint [String] A hint to display below the input field, providing
  # additional context or instructions for the user. This is optional. See
  # https://flowbite.com/docs/forms/input-field/#helper-text
  #
  # @param disabled [Boolean] Whether the input field should be disabled.
  # Defaults to `false`.
  #
  # @param input_attributes [Hash] Additional HTML attributes to pass to the
  # input element.
  #
  # @param size [Symbol] The size of the input field. Can be one of `:sm`,
  # `:md`, or `:lg`. Defaults to `:md`.
  #
  # Sample usage
  #
  #     <% form_for @person do |form| %>
  #       <%= render(
  #         Flowbite::InputField::Number.new(
  #           :attribute => :name,
  #           :form => form
  #         )
  #       ) %>
  #     <% end %>
  #
  # To render an input without labels or error messages etc, use
  # `Flowbite::Input::Field` instead.
  class InputField < ViewComponent::Base
    # Returns the errors for attribute
    def errors
      @object.errors[@attribute] || []
    end

    def initialize(attribute:, form:, disabled: false, hint: nil, input_attributes: {}, size: :default)
      super
      @attribute = attribute
      @disabled = disabled
      @form = form
      @hint = hint
      @input_attributes = input_attributes
      @object = form.object
      @size = size
    end

    def input_component
      ::Flowbite::Input::Field
    end

    # Returns the HTML to use for the hint element if any
    def hint
      return unless hint?

      render(Flowbite::Input::Hint.new(
        @form,
        @attribute,
        hint: @hint,
        hint_attributes: {id: id_for_hint_element}
      ))
    end

    # Returns the HTML to use for the actual input field element.
    def input
      render(input_component.new(
        @form,
        @attribute,
        disabled: @disabled,
        input_attributes: default_input_attributes.merge(@input_attributes),
        size: @size
      ))
    end

    # Returns the HTML to use for the label element
    def label
      render(Flowbite::Input::Label.new(@form, @attribute))
    end

    protected

    # Returns a Hash with the default attributes to apply to the input element.
    #
    # The default attributes can be overriden by passing the `input_attributes`
    # argument to the constructor.
    def default_input_attributes
      if hint?
        {
          "aria-describedby": id_for_hint_element
        }
      else
        {}
      end
    end

    # Returns true if the input field has a hint, false otherwise.
    def hint?
      @hint.present?
    end

    def id_for_hint_element
      "#{@form.object_name}_#{@attribute}_hint"
    end
  end
end
