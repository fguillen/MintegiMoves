require "test_helper"

class Front::CategoriesControllerTest < ActionController::TestCase
  def test_show
    category = FactoryGirl.create(:category)
    category.items << FactoryGirl.create(:item)
    category.items << FactoryGirl.create(:item)

    get :show, :id => category

    assert :success
    assert_template "front/categories/show"
    assert_equal(category, assigns(:category))
  end
end
