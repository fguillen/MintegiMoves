require "test_helper"

class Admin::CategoriesControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_show
    category = FactoryGirl.create(:category)

    get :show, :id => category

    assert_template "admin/categories/show"
    assert_equal(category, assigns(:category))
  end

  def test_edit
    category = FactoryGirl.create(:category)

    get :edit, :id => category

    assert_template "edit"
    assert_equal(category, assigns(:category))
  end

  def test_update_invalid
    category = FactoryGirl.create(:category)
    Category.any_instance.stubs(:valid?).returns(false)

    put :update, :id => category

    assert_template "edit"
    assert_not_nil(flash[:alert])
  end

  def test_update_valid
    category = FactoryGirl.create(:category)

    put(
      :update,
      :id => category,
      :category => {
        :title => "Other Title"
      }
    )

    category.reload

    assert_redirected_to [:admin, category]
    assert_not_nil(flash[:notice])

    assert_equal("Other Title", category.title)
  end

  def test_log_book_events
    category = FactoryGirl.create(:category)
    category.log_book_events << FactoryGirl.create(:log_book_event)

    get :log_book_events, :id => category

    assert_template "log_book_events"
  end
end
