require "test_helper"

class Front::ItemsControllerTest < ActionController::TestCase
  def test_show
    category = FactoryGirl.create(:category)
    item = FactoryGirl.create(:item, :category => category)

    get :show, :category_id => category, :id => item

    assert :success
    assert_template "front/items/show"
    assert_equal(item, assigns(:item))
  end
end
