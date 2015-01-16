require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do
    context "when not logged in" do
      should "redirect when not logged in " do
        get :new
        assert_response :redirect
      end
    end

    context "when logged in" do
      setup do
        sign_in users(:prabhakar)
      end
      should "get new page and return success" do
        get :new
        assert_response :success
      end

      should "should set the flash error if the friend_id is missing" do
        get :new, {}
        assert_equal "Friend required", flash[:error]
      end

      should "display the friends name" do
        get :new, friend_id: users(:steve).id
        assert_match /#{users(:steve).full_name}/, response.body 
      end

      should "assign a new user_friendship" do
        get :new, friend_id: users(:steve).id
        assert assigns(:user_friendship)
      end

      should "assign a new user friendship to the correct friend" do
        get :new, friend_id: users(:steve).id
        assert_equal users(:steve), assigns(:user_friendship).friend
      end

      should "assign the new usser_friendship to the currently logged in user" do
        get :new, friend_id: users(:steve).id
        assert_equal users(:prabhakar), assigns(:user_friendship).user
      end

      should "render 404 if the friend is not found" do
        get :new, friend_id: 'invalid'
        assert_response :not_found
      end
    end 
  end
end
