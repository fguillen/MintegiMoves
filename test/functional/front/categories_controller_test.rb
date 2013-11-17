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

  def test_show_without_params
    category_1 = FactoryGirl.create(:category, :position => 2)
    category_2 = FactoryGirl.create(:category, :position => 1)

    get :show

    assert :success
    assert_template "front/categories/show"
    assert_equal(category_2, assigns(:category))
  end
end
