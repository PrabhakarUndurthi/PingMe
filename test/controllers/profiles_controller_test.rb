require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase

  test "should get show" do
    get :show, id: users(:prabhakar).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  # test "should render 404 if the profile is not found" do
  #   get :show, id: "does't exist"
  #   assert_response :not_found
  # end

  test " correctly assign the users profile name" do
    get :show, id: users(:prabhakar).profile_name
    assert assigns(:user)
    assert_not_empty assigns(:statuses)
  end

  test "only shows the statuses of current_user" do
    get :show, id: users(:prabhakar).profile_name
    assigns(:statuses).each do |status|
      assert_equal users(:prabhakar), status.user
    end
  end

end
