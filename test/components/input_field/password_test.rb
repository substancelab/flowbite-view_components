require "test_helper"

require "support/models"

class Flowbite::InputField::PasswordTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @user = User.new(name: "John Doe", password: "secret123")
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:user, @user, @view_context, {})
  end

  def test_renders_a_password_input_element
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password))

    assert_selector("input[type='password'][name='user[password]']")
  end

  def test_renders_a_label
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password))

    assert_selector("label[for='user_password']")
  end

  def test_renders_a_hint
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password, hint: "Enter a secure password"))

    assert_selector("input[type='password']")
    assert_selector("p", text: "Enter a secure password")
  end

  def test_adds_aria_attributes_for_hint
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password, hint: "Enter a secure password"))

    assert_selector("input[aria-describedby='user_password_hint']")
    assert_selector("p#user_password_hint", text: "Enter a secure password")
  end

  def test_passes_input_attributes_to_input_element
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password, input_attributes: {placeholder: "Enter password"}))

    assert_selector("input[type='password'][placeholder='Enter password']")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password, size: :sm))

    assert_selector("input.p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password, size: :lg))

    assert_selector("input.text-base")
  end

  def test_does_not_show_password_value
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password))

    refute_selector("input[value='secret123']")
  end

  def test_renders_disabled_password
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password, disabled: true))

    assert_selector("input[type='password'][disabled]")
  end

  def test_renders_enabled_password_by_default
    render_inline(Flowbite::InputField::Password.new(form: @form, attribute: :password))

    assert_no_selector("input[disabled]")
  end
end