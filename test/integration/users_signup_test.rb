require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	# test "the truth" do
	#   assert true
	# end
	test "user should not signup with invalid form data" do
		get signup_path
		assert_select 'form[action=?]', signup_path
		assert_no_difference 'User.count' do
			post signup_path,
				 params: { user: {
					 name: "ana",
					 email: "anandmukul93@gmail.com",
					 password: "123",
					 password_confirmation: "13"
				 }
				 }
		end
		assert_template 'users/new'
		# assert_select "li.error-message", "Email has already been taken"
		assert_select "li.error-message", "Password is too short (minimum is 7 characters)"
		assert_select "li.error-message", "Password confirmation doesn't match Password"
	end

	test "valid user signup" do
		get signup_path
		assert_select "form[action=?]", signup_path
		assert_difference 'User.count', 1 do
			post signup_path, params: { user: { name:  "Example User",
												email: "user@example.com",
												password:              "password",
												password_confirmation: "password" } }
		end
		user = User.find_by(email: "user@example.com")
		assert_redirected_to user
		follow_redirect!
		assert_not flash.empty?
		assert_template 'users/show'
		assert is_logged_in?
	end
end
