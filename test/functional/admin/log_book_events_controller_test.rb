require "test_helper"

class Admin::LogBookEventsControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_index
    log_book_event_1 = FactoryGirl.create(:log_book_event)
    log_book_event_2 = FactoryGirl.create(:log_book_event)

    get :index

    assert_template "admin/log_book_events/index"
    assert_equal([log_book_event_2, log_book_event_1].ids, assigns(:log_book_events).ids)
  end

end
