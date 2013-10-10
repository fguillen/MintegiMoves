require "test_helper"

class Admin::AdminHelperTest < ActionView::TestCase
  def test_admin_menu_class
    request_mock = mock
    self.stubs(:request).returns(request_mock)

    request_mock.stubs(:fullpath).returns("/wadus/wadus")
    assert_equal("no-active", admin_menu_class(:admin_users))

    request_mock.stubs(:fullpath).returns("/admin/admin_users")
    assert_equal("active", admin_menu_class(:admin_users))

    request_mock.stubs(:fullpath).returns("/admin/admin_users/1")
    assert_equal("active", admin_menu_class(:admin_users))

    request_mock.stubs(:fullpath).returns("/admin/admin_users/1/edit")
    assert_equal("active", admin_menu_class(:admin_users))

    request_mock.stubs(:fullpath).returns("/admin")
    assert_equal("active", admin_menu_class(:items))

    request_mock.stubs(:fullpath).returns("/admin/items")
    assert_equal("active", admin_menu_class(:items))

    request_mock.stubs(:fullpath).returns("/admin/items/1")
    assert_equal("active", admin_menu_class(:items))

    request_mock.stubs(:fullpath).returns("/admin/items/1/edit")
    assert_equal("active", admin_menu_class(:items))

    request_mock.stubs(:fullpath).returns("/admin/log_book_events")
    assert_equal("active", admin_menu_class(:log_book_events))
  end

end
