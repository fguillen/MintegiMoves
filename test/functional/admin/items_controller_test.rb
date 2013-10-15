require "test_helper"

class Admin::ItemsControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_index
    category_1 = FactoryGirl.create(:category)
    category_2 = FactoryGirl.create(:category)

    item_1 = FactoryGirl.create(:item, :category => category_1)
    item_2 = FactoryGirl.create(:item, :category => category_1)
    item_3 = FactoryGirl.create(:item, :category => category_2)

    get :index

    assert_template "admin/items/index"
    assert_equal([item_2, item_1].ids, assigns(:items).ids)
  end

  def test_index_with_category_id_param
    category_1 = FactoryGirl.create(:category)
    category_2 = FactoryGirl.create(:category)

    item_1 = FactoryGirl.create(:item, :category => category_1)
    item_2 = FactoryGirl.create(:item, :category => category_1)
    item_3 = FactoryGirl.create(:item, :category => category_2)

    get :index, :category_id => category_2.id

    assert_template "admin/items/index"
    assert_equal([item_3].ids, assigns(:items).ids)
  end

  def test_show
    item = FactoryGirl.create(:item)

    get :show, :id => item

    assert_template "admin/items/show"
    assert_equal(item, assigns(:item))
  end

  def test_new
    get :new
    assert_template "admin/items/new"
    assert_not_nil(assigns(:item))
  end

  def test_create_invalid
    Item.any_instance.stubs(:valid?).returns(false)

    post :create

    assert_template "new"
    assert_not_nil(flash[:alert])
  end

  def test_create_valid
    category = FactoryGirl.create(:category)

    post(
      :create,
      :item => {
        :title => "Item Title",
        :intro => "Intro **text**",
        :text => "My **text**",
        :category_id => category
      }
    )

    item = Item.last
    assert_redirected_to [:admin, item]

    assert_equal("Item Title", item.title)
    assert_equal("Intro **text**", item.intro)
    assert_equal("My **text**", item.text)
  end

  def test_edit
    item = FactoryGirl.create(:item)

    get :edit, :id => item

    assert_template "edit"
    assert_equal(item, assigns(:item))
  end

  def test_update_invalid
    item = FactoryGirl.create(:item)
    Item.any_instance.stubs(:valid?).returns(false)

    put :update, :id => item

    assert_template "edit"
    assert_not_nil(flash[:alert])
  end

  def test_update_valid
    item = FactoryGirl.create(:item)

    put(
      :update,
      :id => item,
      :item => {
        :title => "Other Title"
      }
    )

    item.reload

    assert_redirected_to [:admin, item]
    assert_not_nil(flash[:notice])

    assert_equal("Other Title", item.title)
  end

  def test_destroy
    item = FactoryGirl.create(:item)

    delete :destroy, :id => item

    assert_redirected_to :admin_items
    assert_not_nil(flash[:notice])

    assert !Item.exists?(item.id)
  end

  def test_reorder
    item_1 = FactoryGirl.create(:item, :position => 1)
    item_2 = FactoryGirl.create(:item, :position => 2)
    item_3 = FactoryGirl.create(:item, :position => 3)

    assert_equal([item_1, item_2, item_3].ids, Item.by_position.ids)

    post(
      :reorder,
      :ids => [item_2, item_3, item_1].ids
    )

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_equal("ok", JSON.parse(response.body)["status"])

    assert_equal([item_2, item_3, item_1].ids, Item.by_position.ids)
  end

  def test_log_book_events
    item = FactoryGirl.create(:item)
    item.log_book_events << FactoryGirl.create(:log_book_event)

    get :log_book_events, :id => item

    assert_template "log_book_events"
  end
end
