require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

    test "login with invalid information" do
        get index_path
        assert_template 'sessions/new'
        post login_path, params: {session: {email:"sff@fsdf", password: "sfsfsfsf"}}
        assert_template 'sessions/new'
        assert_not flash.empty?
        get root_path
        assert flash.empty?
    end
end
