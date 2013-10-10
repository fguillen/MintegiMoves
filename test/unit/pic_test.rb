require "test_helper"

class PicTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:pic).valid?
  end

  def test_attach
    item = FactoryGirl.create(:item, :id => 1001)

    pic =
      Pic.create!(
        :item => item,
        :attach => File.open(fixture("pic.jpg")),
      )

    assert_match(/\/assets\/uploads\/test\/1001\/#{pic.id}_front.jpg/, pic.attach(:front))
    assert_match(/\/assets\/uploads\/test\/1001\/#{pic.id}_admin.jpg/, pic.attach(:admin))
  end

  def test_scope_by_position
    pic_1 = FactoryGirl.create(:pic, :position => 10)
    pic_2 = FactoryGirl.create(:pic, :position => 9)

    assert_equal([pic_2, pic_1].ids, Pic.by_position.ids)
  end

  def test_title
    pic = FactoryGirl.create(:pic, :attach => File.open(fixture("pic.jpg")))
    assert_equal("pic", pic.title)

    pic = FactoryGirl.create(:pic, :attach => File.open(fixture("_pic.jpg")))
    assert_equal(nil, pic.title)

    pic = FactoryGirl.create(:pic, :attach => File.open(fixture("Pic With Spaces.jpg")))
    assert_equal("Pic With Spaces", pic.title)
  end
end
