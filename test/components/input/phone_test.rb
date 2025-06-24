require "test_helper"

require "support/models"

class Flowbite::Input::PhoneTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @user = User.new(name: "John Doe", phone: "+1-555-123-4567")
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:user, @user, @view_context, {})
  end

  def test_renders_a_phone_input
    render_inline(Flowbite::Input::Phone.new(@form, :phone))

    assert_selector("input[type='tel'][name='user[phone]'][value='+1-555-123-4567']")
  end

  def test_renders_with_default_state
    render_inline(Flowbite::Input::Phone.new(@form, :phone))

    assert_selector("input[name='user[phone]'].border-gray-300")
  end

  def test_renders_in_error_state
    @user.errors.add(:phone, :invalid)
    render_inline(Flowbite::Input::Phone.new(@form, :phone))

    assert_selector("input[name='user[phone]'].border-red-500")
  end

  def test_renders_in_disabled_state
    render_inline(Flowbite::Input::Phone.new(@form, :phone, disabled: true))

    assert_selector("input[name='user[phone]'][disabled].bg-gray-100.border.border-gray-300.text-gray-900.cursor-not-allowed")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::Input::Phone.new(@form, :phone, size: :sm))

    assert_selector("input[name='user[phone]'].p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::Input::Phone.new(@form, :phone, size: :lg))

    assert_selector("input[name='user[phone]'].text-base")
  end

  def test_adds_attributes_to_input
    render_inline(Flowbite::Input::Phone.new(@form, :phone, input_attributes: {placeholder: "Enter phone number"}))

    assert_selector("input[name='user[phone]'][placeholder='Enter phone number']")
  end
end
