if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start "rails"
end

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "mocha/setup"
require_relative "factories"


class ActiveSupport::TestCase
  FIXTURES_PATH = "#{File.dirname(__FILE__)}/fixtures"

  def fixture(fixture_path)
    File.expand_path "#{FIXTURES_PATH}/#{fixture_path}"
  end

  def assert_no_template(template, msg = nil)
    msg ||= "Not expected template: '#{template}'"

    assert !@templates.any? {|t, num| t.match(template)}, msg
  end

  def write_fixture(fixture_path, content)
    puts "ATENTION: fixture: '#{fixture_path}' been written"
    File.open(fixture(fixture_path), "w") { |f| f.write content }
  end

  def setup_admin_user
    @admin_user = FactoryGirl.create(:admin_user)
    @controller.stubs(:current_admin_user).returns(@admin_user)
  end

  def assert_ids(array_1, array_2, message = nil)
    assert_block do
      assert_equal(array_1.ids, array_2.ids)
    end
  end
end


require "capybara/rails"

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  self.use_transactional_fixtures = false

  def setup
    Capybara.javascript_driver = :selenium
    Capybara.current_driver = :selenium
    Capybara.default_selector = :css
    # Capybara.browser = :chrome
  end

  def teardown
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end

  def setup_admin_user
    @admin_user = FactoryGirl.create(:admin_user)

    visit admin_login_path
    fill_in "admin_user_session_email", :with => @admin_user.email
    fill_in "admin_user_session_password", :with => "pass"
    click_button "Sign in"

    page.has_content?("Admin User authenticated!")
  end
end
