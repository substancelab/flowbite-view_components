require "test_helper"

require "support/models"

class Flowbite::Input::FieldTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald")
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:book, @book, @view_context, {})
  end

  def test_renders_a_text_input
    render_inline(Flowbite::Input::Field.new(@form, :title))

    assert_component_rendered
    assert_selector("input[type='text'][name='book[title]'][value='The Great Gatsby']")
  end

  def test_renders_with_default_state
    render_inline(Flowbite::Input::Field.new(@form, :title))

    assert_component_rendered
    assert_selector("input[name='book[title]'].border-gray-300")
  end

  def test_renders_in_error_state
    @book.errors.add(:title, :invalid)
    render_inline(Flowbite::Input::Field.new(@form, :title))

    assert_component_rendered
    assert_selector("input[name='book[title]'].border-red-500")
  end

  def test_renders_in_disabled_state
    render_inline(Flowbite::Input::Field.new(@form, :title, disabled: true))

    assert_component_rendered
    assert_selector("input[name='book[title]'][disabled].bg-gray-100.border.border-gray-300.text-gray-900.cursor-not-allowed")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::Input::Field.new(@form, :title, size: :sm))

    assert_component_rendered
    assert_selector("input[name='book[title]'].p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::Input::Field.new(@form, :title, size: :lg))

    assert_component_rendered
    assert_selector("input[name='book[title]'].text-base")
  end

  def test_adds_attributes_to_input
    render_inline(Flowbite::Input::Field.new(@form, :title, input_attributes: {placeholder: "Enter title"}))

    assert_component_rendered
    assert_selector("input[name='book[title]'][placeholder='Enter title']")
  end
end
