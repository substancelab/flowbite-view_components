require "test_helper"

require "support/models"

class Flowbite::Input::DateTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @book = Book.new(published_at: Date.new(1925, 4, 10))
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:book, @book, @view_context, {})
  end

  def test_renders_a_date_input
    render_inline(Flowbite::Input::Date.new(@form, :published_at))

    assert_selector("input[type='date'][name='book[published_at]'][value='1925-04-10']")
  end

  def test_renders_with_default_state
    render_inline(Flowbite::Input::Date.new(@form, :published_at))

    assert_selector("input[name='book[published_at]'].border-gray-300")
  end

  def test_renders_in_error_state
    @book.errors.add(:published_at, :invalid)
    render_inline(Flowbite::Input::Date.new(@form, :published_at))

    assert_selector("input[name='book[published_at]'].border-red-500")
  end

  def test_renders_in_disabled_state
    render_inline(Flowbite::Input::Date.new(@form, :published_at, disabled: true))

    assert_selector("input[name='book[published_at]'][disabled].bg-gray-100.border.border-gray-300.text-gray-900.cursor-not-allowed")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::Input::Date.new(@form, :published_at, size: :sm))

    assert_selector("input[name='book[published_at]'].p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::Input::Date.new(@form, :published_at, size: :lg))

    assert_selector("input[name='book[published_at]'].text-base")
  end

  def test_adds_attributes_to_input
    render_inline(Flowbite::Input::Date.new(@form, :published_at, input_attributes: {placeholder: "Enter publish date"}))

    assert_selector("input[name='book[published_at]'][placeholder='Enter publish date']")
  end
end
