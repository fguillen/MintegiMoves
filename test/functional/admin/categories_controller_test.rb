require "test_helper"

class Admin::CategorysControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_index
    category_1 = FactoryGirl.create(:category)
    category_2 = FactoryGirl.create(:category)

    get :index

    assert_template "admin/categorys/index"
    assert_equal([category_2, category_1].ids, assigns(:categorys).ids)
  end

  def test_show
    category = FactoryGirl.create(:category)

    get :show, :id => category

    assert_template "admin/categorys/show"
    assert_equal(category, assigns(:category))
  end

  def test_new
    get :new
    assert_template "admin/categorys/new"
    assert_not_nil(assigns(:category))
  end

  def test_create_invalid
    Category.any_instance.stubs(:valid?).returns(false)

    post :create

    assert_template "new"
    assert_not_nil(flash[:alert])
  end

  def test_create_valid
    post(
      :create,
      :category => {
        :title => "Category Title",
        :text => "My **text**"
      }
    )

    category = Category.last
    assert_redirected_to [:admin, category]

    assert_equal("Category Title", category.title)
    assert_equal("My **text**", category.text)
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

  def test_destroy
    category = FactoryGirl.create(:category)

    delete :destroy, :id => category

    assert_redirected_to :admin_categorys
    assert_not_nil(flash[:notice])

    assert !Category.exists?(category.id)
  end

  def test_reorder
    category_1 = FactoryGirl.create(:category, :position => 1)
    category_2 = FactoryGirl.create(:category, :position => 2)
    category_3 = FactoryGirl.create(:category, :position => 3)

    assert_equal([category_1, category_2, category_3].ids, Category.by_position.ids)

    post(
      :reorder,
      :ids => [category_2, category_3, category_1].ids
    )

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_equal("ok", JSON.parse(response.body)["status"])

    assert_equal([category_2, category_3, category_1].ids, Category.by_position.ids)
  end

  def test_log_book_events
    category = FactoryGirl.create(:category)
    category.log_book_events << FactoryGirl.create(:log_book_event)

    get :log_book_events, :id => category

    assert_template "log_book_events"
  end
end
