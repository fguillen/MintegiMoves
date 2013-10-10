require "test_helper"

class Admin::PicsControllerTest < ActionController::TestCase
  def setup
    setup_admin_user
  end

  def test_index
    item = FactoryGirl.create(:item)
    pic_1 = FactoryGirl.create(:pic, :item => item, :attach => File.new(fixture("/pic.jpg")), :position => 1)
    pic_2 = FactoryGirl.create(:pic, :item => item, :attach => File.new(fixture("/pic.jpg")), :position => 2)

    get(:index, :item_id => item)

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_match("#{pic_1.id}_admin.jpg", JSON.parse(response.body).first["file_url"])
    assert_match("#{pic_2.id}_admin.jpg", JSON.parse(response.body).last["file_url"])
  end

  def test_create
    item = FactoryGirl.create(:item)

    post(
      :create,
      :item_id => item,
      :file => fixture_file_upload("/pic.jpg")
    )

    pic = Pic.last

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_match("#{pic.id}_admin.jpg", JSON.parse(response.body)["file_url"])
  end

  def test_destroy
    item = FactoryGirl.create(:item)
    pic = FactoryGirl.create(:pic, :item => item)

    assert_difference "Pic.count", -1 do
      delete(
        :destroy,
        :item_id => item,
        :id => pic
      )
    end

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_equal("ok", JSON.parse(response.body)["status"])

    assert !Pic.exists?(pic.id)
  end

  def test_reorder
    item = FactoryGirl.create(:item)
    pic_1 = FactoryGirl.create(:pic, :position => 1, :item => item)
    pic_2 = FactoryGirl.create(:pic, :position => 2, :item => item)
    pic_3 = FactoryGirl.create(:pic, :position => 3, :item => item)

    item.reload
    assert_equal([pic_1, pic_2, pic_3].map(&:id), item.pics.by_position.map(&:id))

    post(
      :reorder,
      :item_id => item,
      :ids => [pic_2, pic_3, pic_1].map(&:id)
    )

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_equal("ok", JSON.parse(response.body)["status"])

    item.reload
    assert_equal([pic_2, pic_3, pic_1].map(&:id), item.pics.by_position.map(&:id))
  end

end
