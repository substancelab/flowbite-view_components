require "test_helper"

require "support/models"

class Flowbite::Input::NumberTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @product = Product.new(name: "Widget", price: 19.99, quantity: 5)
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:product, @product, @view_context, {})
  end

  def test_renders_a_number_input
    render_inline(Flowbite::Input::Number.new(@form, :price))

    assert_selector("input[type='number'][name='product[price]'][value='19.99']")
  end

  def test_renders_with_default_state
    render_inline(Flowbite::Input::Number.new(@form, :price))

    assert_selector("input[name='product[price]'].border-gray-300")
  end

  def test_renders_in_error_state
    @product.errors.add(:price, :invalid)
    render_inline(Flowbite::Input::Number.new(@form, :price))

    assert_selector("input[name='product[price]'].border-red-500")
  end

  def test_renders_in_disabled_state
    render_inline(Flowbite::Input::Number.new(@form, :price, disabled: true))

    assert_selector("input[name='product[price]'][disabled].bg-gray-100.border.border-gray-300.text-gray-900.cursor-not-allowed")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::Input::Number.new(@form, :price, size: :sm))

    assert_selector("input[name='product[price]'].p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::Input::Number.new(@form, :price, size: :lg))

    assert_selector("input[name='product[price]'].text-base")
  end

  def test_adds_attributes_to_input
    render_inline(Flowbite::Input::Number.new(@form, :price, input_attributes: {placeholder: "Enter price", step: "0.01"}))

    assert_selector("input[name='product[price]'][placeholder='Enter price'][step='0.01']")
  end

  def test_renders_integer_field
    render_inline(Flowbite::Input::Number.new(@form, :quantity))

    assert_selector("input[type='number'][name='product[quantity]'][value='5']")
  end
end
