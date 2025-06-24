require "test_helper"

require "support/models"

class Flowbite::InputFieldTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", state: "read")
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:book, @book, @view_context, {})
  end

  def test_renders_a_hint
    render_inline(Flowbite::InputField.new(form: @form, attribute: :title, hint: "What's the title?"))

    assert_selector("input[type='text'][value='The Great Gatsby']")
    assert_selector("p", text: "What's the title?")
  end

  def test_adds_aria_attributes_for_hint
    render_inline(Flowbite::InputField.new(form: @form, attribute: :title, hint: "What's the title?"))

    assert_selector("input[aria-describedby='book_title_hint']")
    assert_selector("p#book_title_hint", text: "What's the title?")
  end

  def test_renders_an_input_element
    render_inline(Flowbite::InputField.new(form: @form, attribute: :title))

    assert_component_rendered
    assert_selector("input[type='text'][value='The Great Gatsby']")
  end

  def test_renders_a_label
    render_inline(Flowbite::InputField.new(form: @form, attribute: :title))

    assert_component_rendered
    assert_selector("label[for='book_title']")
  end

  def test_passes_input_attributes_to_input_element
    render_inline(Flowbite::InputField.new(form: @form, attribute: :title, input_attributes: {placeholder: "Enter title"}))

    assert_component_rendered
    assert_selector("input[type='text'][placeholder='Enter title']")
  end

  def test_renders_a_large_select_element
    render_inline(Flowbite::InputField::Select.new(form: @form, attribute: :state, collection: ["read", "unread"], size: :lg))

    assert_selector("select.text-base.px-4.py-3")
  end

  def test_passes_input_attributes_to_select_element
    render_inline(Flowbite::InputField::Select.new(form: @form, attribute: :state, collection: ["read", "unread"], input_attributes: {"data-key": "state-select"}))

    assert_selector("select[data-key='state-select']")
  end

  def test_renders_disabled_input_field
    render_inline(Flowbite::InputField.new(form: @form, attribute: :title, disabled: true))

    assert_selector("input[disabled]")
  end

  def test_renders_enabled_input_field_by_default
    render_inline(Flowbite::InputField.new(form: @form, attribute: :title))

    assert_no_selector("input[disabled]")
  end
end
