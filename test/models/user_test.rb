require "test_helper"

class UserTest < ActiveSupport::TestCase
  #Method setup intialize instance variable available for the test
  def setup
    @user = User.new(name:"aymeric", email:"aymeric@gmail.com",
                    password: "foobar", password_confirmation: "foobar")
  end
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "         "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.name = "        "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = ("a"*244) + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user=@user.dup
    @user.save!
    assert_not duplicate_user.valid?
  end

  test "email addresses should be save as lower cases" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal @user.email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password =@user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should contain at least 6 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
