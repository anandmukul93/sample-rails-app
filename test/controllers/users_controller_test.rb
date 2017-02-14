require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:anand)
		@other_user = users(:kanan)
	end

	test "should get new" do
		get signup_url
		assert_response :success
	end

	test "edit should redirect to login if not logged in " do
		get edit_user_path(@user)
		assert_not flash.empty?
		assert_redirected_to login_path
	end

	test "should redirect update when user not logged in" do
		patch user_path(@user), params:{user:{name:"something", email:"anothersomething@gmial.com"}}
		assert_not flash.empty?
		assert_redirected_to login_path
	end

	test "should redirect edit to current logged in user url when viewing edit of another user" do
		log_in_as @user
		get edit_user_path(@other_user)
		assert flash.empty?
		assert_redirected_to @user
	end

	test "should redirect update to current logged in user url when updating fields of another user" do
		log_in_as @user
		patch user_path(@other_user), params: {user:{name: "something", email:"something@something.com"}}
		assert flash.empty?
		assert_redirected_to @user
	end

	test "should redirect index page when user not logged in " do
		get users_path
		assert_redirected_to login_url
	end

	test "should not allow the users to change the admin attribute via the web" do
		log_in_as (@other_user)
		assert_not @other_user.admin?
		patch user_path(@other_user), params:{user:{password: "something", password_confirmation:"something", admin:true}}
		assert_not @other_user.admin?
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'User.count' do
			delete user_path(@user)
		end
		assert_redirected_to login_url
	end


	test "only admin should delete another user not himself" do
		log_in_as (@other_user)
		assert_no_difference 'User.count' do
			delete user_path(@user)
		end
		assert_redirected_to users_path
		delete logout_path
		log_in_as(@user)

		assert_no_difference 'User.count' do
			delete user_path(@user)
		end
		assert_redirected_to users_path

		assert_difference 'User.count', -1 do
			delete user_path(@other_user)
		end
		assert_redirected_to users_path
	end
end
