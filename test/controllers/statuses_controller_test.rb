require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when  logged in" do
    sign_in users(:prabhakar)
    get :new
    assert_response :success
  end

  test "should be logged in to post a status " do

    post :create, status: {content: "Hello"}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create status when logged in" do
    sign_in users(:prabhakar)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status only for the current user when logged in" do
    sign_in users(:prabhakar)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:steve).id }
    end
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:prabhakar).id
  end 

  test "should update the status for the currently logged in users" do
    sign_in users(:prabhakar)
    put :update, id: @status, status: {content: @status.content, user_id: users(:steve).id}
    assert_redirected_to status_path (assigns(:status))
    assert_equal assigns(:status).user_id, users(:prabhakar).id
  end

  test "status should not be updated if nothing changed" do
    sign_in users(:prabhakar)
    put :update, id: @status
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:prabhakar).id
  end


  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should allow the user to edit when logged in" do
    sign_in users(:prabhakar)
    get :edit, id: @status
    assert_response :success
  end

  test "should redirect when the user not logged in" do
    patch :update, id: @status, status: {content: @status.content}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
