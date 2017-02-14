require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	# test "the truth" do
	#   assert true
	# end

	def setup
		@user = users(:anand)
	end

	test "unsuccessful edit " do
		log_in_as @user
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params:{user: { name: "", password: "foo", password_confirmation: "bar", email: "foo@invalid"}}
		assert_template 'users/edit'
		assert_select 'div.alert', "The form contains 4 errors"
	end

	test "successful edit" do
		log_in_as @user
		get edit_user_path(@user)
		assert_template "users/edit"
		name = "something something"
		email = "something@something.com"
		patch user_path(@user), params:{user:{name: name, email: email, password: "", password_confirmation: ""}}
		assert_not flash.empty?
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email, email
	end
end
