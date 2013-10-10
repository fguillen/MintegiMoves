require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:category).valid?
  end

  def test_on_create_initialize_position
    category_1 = FactoryGirl.create(:category, :position => 10)
    category_2 = FactoryGirl.create(:category)

    assert_equal(9, category_2.position)
  end

  def test_scope_by_position
    category_1 = FactoryGirl.create(:category, :position => 10)
    category_2 = FactoryGirl.create(:category, :position => 9)

    assert_equal([category_2, category_1].ids, Category.by_position.ids)
  end
end
