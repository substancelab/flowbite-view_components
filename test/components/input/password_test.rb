require "test_helper"

require "support/models"

class Flowbite::Input::PasswordTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @user = User.new(name: "John Doe", password: "secret123")
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:user, @user, @view_context, {})
  end

  def test_renders_a_password_input
    render_inline(Flowbite::Input::Password.new(@form, :password))

    assert_selector("input[type='password'][name='user[password]']")
  end

  def test_renders_with_default_state
    render_inline(Flowbite::Input::Password.new(@form, :password))

    assert_selector("input[name='user[password]'].border-gray-300")
  end

  def test_renders_in_error_state
    @user.errors.add(:password, :invalid)
    render_inline(Flowbite::Input::Password.new(@form, :password))

    assert_selector("input[name='user[password]'].border-red-500")
  end

  def test_renders_in_disabled_state
    render_inline(Flowbite::Input::Password.new(@form, :password, disabled: true))

    assert_selector("input[name='user[password]'][disabled].bg-gray-100.border.border-gray-300.text-gray-900.cursor-not-allowed")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::Input::Password.new(@form, :password, size: :sm))

    assert_selector("input[name='user[password]'].p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::Input::Password.new(@form, :password, size: :lg))

    assert_selector("input[name='user[password]'].text-base")
  end

  def test_adds_attributes_to_input
    render_inline(Flowbite::Input::Password.new(@form, :password, input_attributes: {placeholder: "Enter password"}))

    assert_selector("input[name='user[password]'][placeholder='Enter password']")
  end

  def test_does_not_show_password_value
    render_inline(Flowbite::Input::Password.new(@form, :password))

    refute_selector("input[value='secret123']")
  end
end