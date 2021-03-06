require 'test_helper'

# rails generate integration_test site_layout
# rails test:integration

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home' # controller/action
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", helf_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end
end