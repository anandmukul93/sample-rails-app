require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
    # test "the truth" do
    #   assert true
    # end

    test "site layout links" do
        get index_path
        assert_template 'static_pages/home'
        assert_select "a[href=?]",index_path, count:2
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", contact_page_path
        get contact_page_path
        assert_select "title", full_title("Contact")
    end
end
