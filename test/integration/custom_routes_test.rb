require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest

  test "that /register route opens the register page" do
    get '/register'
    assert_response :success
  end

  test "/login route opens the opens the login page" do
    get '/login'
    assert_response :success
  end

  test "/logout route opens the logout page" do
    get '/logout'
    assert_response :redirect
    assert_redirected_to  '/'
  end
end
