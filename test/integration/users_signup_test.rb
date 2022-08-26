require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  #Using invalid input, test validating a wrong sign up process with the redirection on the sign up page
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "ben", email:"ben@gmocom",
                                password:"azerty", password_confirmation:"azerty"}}
    end
    assert_template 'users/new'
  end


  #Using valid input, test validating the sign up process and the redirection to show of the newly created user is displayed
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: {user:{name:"Rails", email: "ruby@rails.com",
                                password: "azerty", password_confirmation: "azerty"}}
    end
    #Follow the redirect defined in the user controller in case of success
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
  # test "the truth" do
  #   assert true
  # end
end
