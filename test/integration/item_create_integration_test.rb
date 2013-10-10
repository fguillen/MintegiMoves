require "test_helper"

class Admin::ItemCreateIntegrationTestTest < ActionDispatch::IntegrationTest
  def setup
    super

    setup_admin_user
  end

  def test_create_performance
    visit admin_items_path
    click_link "New Item"

    fill_in "item_title", :with => "This is the new item"
    fill_in "item_text", :with => "This is the **text**."
    click_button "Create Item"

    performance = Item.last
    assert_equal("This is the new item", performance.title)

    page.has_content?("Successfully created item")
    page.has_content?("<p>This is the <strong>text</strong>.</p>")
  end
end
