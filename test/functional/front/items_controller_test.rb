require "test_helper"

class Front::ItemsControllerTest < ActionController::TestCase
  def test_show
    item = FactoryGirl.create(:item)

    get :show, :id => item

    assert :success
    assert_template "front/items/show"
    assert_equal(item, assigns(:item))
  end
end
