require "test_helper"

class Front::PagesControllerTest < ActionController::TestCase
  def test_show
    get :show, :id => "about"

    assert :success
    assert_template "front/pages/about"
  end
end
