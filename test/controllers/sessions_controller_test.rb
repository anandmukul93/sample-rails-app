require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
    test "should get new" do
        get sessions_new_url
        #puts sessions_new_url, login_url, login_path, sessions_new_path, new_session_path, new_session_url
        assert_response :success
    end


end
