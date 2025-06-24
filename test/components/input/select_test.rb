require "test_helper"

require "support/models"

class Flowbite::Input::SelectTest < Minitest::Test
  include ViewComponent::TestHelpers

  def setup
    @categories = [
      Category.new(1, "Technology"),
      Category.new(2, "Science"),
      Category.new(3, "Sports")
    ]
    @article = Article.new(title: "Test Article", category_id: 2)
    @view_context = ActionController::Base.new.view_context
    @form = ActionView::Helpers::FormBuilder.new(:article, @article, @view_context, {})
  end

  def test_renders_a_select_input
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: @categories.map { |c| [c.name, c.id] }))

    assert_selector("select[name='article[category_id]']")
    assert_selector("option[value='1']", text: "Technology")
    assert_selector("option[value='2'][selected]", text: "Science")
    assert_selector("option[value='3']", text: "Sports")
  end

  def test_renders_with_default_classes
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: @categories.map { |c| [c.name, c.id] }))

    assert_selector("select[name='article[category_id]'].bg-gray-50.border-gray-300.text-gray-900.rounded-lg")
  end

  def test_renders_in_error_state
    @article.errors.add(:category_id, :invalid)
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: @categories.map { |c| [c.name, c.id] }))

    assert_selector("select[name='article[category_id]'].border-red-500")
  end

  def test_renders_in_disabled_state
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: @categories.map { |c| [c.name, c.id] }, disabled: true))

    assert_selector("select[name='article[category_id]'][disabled].bg-gray-100.border.border-gray-300.text-gray-900.cursor-not-allowed")
  end

  def test_renders_with_empty_collection
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: []))

    assert_selector("select[name='article[category_id]']")
    refute_selector("option")
  end

  def test_renders_with_sm_size
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: @categories.map { |c| [c.name, c.id] }, size: :sm))

    assert_selector("select.p-2.text-xs")
  end

  def test_renders_with_lg_size
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: @categories.map { |c| [c.name, c.id] }, size: :lg))

    assert_selector("select.px-4.py-3.text-base")
  end

  def test_adds_attributes_to_input
    render_inline(Flowbite::Input::Select.new(@form, :category_id, collection: @categories.map { |c| [c.name, c.id] }, input_attributes: {"data-controller": "interactive"}))

    assert_selector("select[name='article[category_id]'][data-controller='interactive']")
  end
end
