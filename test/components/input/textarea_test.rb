require "test_helper"

require "support/models"

class Flowbite::Input::TextareaTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @article = Article.new(title: "Test Article", content: "This is the article content.\nIt has multiple lines.")
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:article, @article, @view_context, {})
  end

  def test_renders_a_textarea
    render_inline(Flowbite::Input::Textarea.new(@form, :content))

    assert_selector("textarea[name='article[content]']", text: "This is the article content.\nIt has multiple lines.")
  end

  def test_renders_with_default_classes
    render_inline(Flowbite::Input::Textarea.new(@form, :content))

    assert_selector("textarea[name='article[content]'].block.p-2\\.5.w-full.text-sm.bg-gray-50.border-gray-300.rounded-lg")
  end

  def test_renders_in_error_state
    @article.errors.add(:content, :invalid)
    render_inline(Flowbite::Input::Textarea.new(@form, :content))

    assert_selector("textarea[name='article[content]'].border-red-500")
  end

  def test_renders_in_disabled_state
    render_inline(Flowbite::Input::Textarea.new(@form, :content, disabled: true))

    assert_selector("textarea[name='article[content]'][disabled].bg-gray-100.border.border-gray-300.text-gray-900.cursor-not-allowed")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::Input::Textarea.new(@form, :content, size: :sm))

    assert_selector("textarea[name='article[content]'].p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::Input::Textarea.new(@form, :content, size: :lg))

    assert_selector("textarea[name='article[content]'].text-base")
  end

  def test_adds_attributes_to_textarea
    render_inline(Flowbite::Input::Textarea.new(@form, :content, input_attributes: {placeholder: "Enter article content", rows: 10}))

    assert_selector("textarea[name='article[content]'][placeholder='Enter article content'][rows='10']")
  end
end
