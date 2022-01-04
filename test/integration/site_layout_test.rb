require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 4
    assert_select "a[href=?]", about_path, count: 2

    get about_path
    assert_template 'static_pages/about'
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", about_path, count: 2
  end

end
