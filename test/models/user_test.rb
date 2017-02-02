require 'test_helper'

class UserTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
    def setup
        @user = User.new(name:"mukul", email:"anandmukul93@gmail.com",
                         password: "example1", password_confirmation: "example1")
    end

    test "do model validation" do
        assert @user.valid?
    end

    test "name should be present" do
        @user.name = ""
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = "    "
        assert_not @user.valid?
    end

    test "email should not be too long" do
        @user.email = "a" *244 + "@example.com"
        assert_not @user.valid?
    end

    test "name should not be too long" do
        @user.name = "a" * 45 + "b" *10
        assert_not @user.valid?
    end

    test "email should reject the wrong format" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com ..@c.com __.abc.@b.c.dom foo.bar@x..com]
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
        end
    end

    test "email should accept the right format" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            assert @user.valid?, "#{valid_address.inspect} should be accepted"
        end
    end

    test "email should be stored in lower case" do
        mixed_case_email = "anAJFD_@fs13.ACI"
        @user.email = mixed_case_email
        @user.save
        assert_equal mixed_case_email.downcase, @user.reload.email
    end

    test "email should not be duplicate" do
        duplicate_user = @user.dup
        @user.save
        assert_not duplicate_user.valid?
    end

    test "should not add valid user without password" do
        user_without_password = @user.dup
        @user.password = nil
        assert_not @user.valid?, "user : #{@user.email.inspect} should not be valid with password as: #{@user.password.inspect}"
        @user.password = "example1"
        @user.password_confirmation = "   "
        assert_not @user.valid?, "user : #{@user.email.inspect} should not be valid with password not same as password_confirmation"
    end

    test "password should not be blank" do
        @user.password = @user.password_confirmation = " " *7 #satisfies length but not blank criteria
        assert_not @user.valid?
    end

    test "password should have a minimum length" do
        @user.password = @user.password_confirmation = "1233s" #satisfies present but not length criteria
        assert_not @user.valid?
    end
end
