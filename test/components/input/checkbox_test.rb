require "test_helper"

require "support/models"

class Flowbite::Input::CheckboxTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @user = User.new(name: "John Doe", subscribed: true)
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:user, @user, @view_context, {})
  end

  def test_renders_a_checkbox_input
    render_inline(Flowbite::Input::Checkbox.new(@form, :subscribed))

    assert_selector("input[type='checkbox'][name='user[subscribed]'][value='1']")
  end

  def test_renders_checked_when_true
    render_inline(Flowbite::Input::Checkbox.new(@form, :subscribed))

    assert_selector("input[type='checkbox'][checked]")
  end

  def test_renders_unchecked_when_false
    @user.subscribed = false
    render_inline(Flowbite::Input::Checkbox.new(@form, :subscribed))

    assert_selector("input[type='checkbox'][name='user[subscribed]']")
    refute_selector("input[checked]")
  end

  def test_renders_with_default_state
    render_inline(Flowbite::Input::Checkbox.new(@form, :subscribed))

    assert_selector("input[name='user[subscribed]'].border-gray-300")
  end

  def test_adds_attributes_to_input
    render_inline(Flowbite::Input::Checkbox.new(@form, :subscribed, input_attributes: {"data-controller": "checkbox"}))

    assert_selector("input[name='user[subscribed]'][data-controller='checkbox']")
  end

  def test_renders_a_hidden_input_for_the_unchecked_case
    render_inline(Flowbite::Input::Checkbox.new(@form, :subscribed, input_attributes: {"data-controller": "checkbox"}))

    assert_selector("input[type='hidden'][name='user[subscribed]'][value='0']", visible: false)
  end
end
