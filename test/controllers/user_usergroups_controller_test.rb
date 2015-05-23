require 'test_helper'

class UserUsergroupsControllerTest < ActionController::TestCase
  setup do
    @user_usergroup = user_usergroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_usergroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_usergroup" do
    assert_difference('UserUsergroup.count') do
      post :create, user_usergroup: { begin_date: @user_usergroup.begin_date, description: @user_usergroup.description, user_id: @user_usergroup.user_id, usergroup_id: @user_usergroup.usergroup_id }
    end

    assert_redirected_to user_usergroup_path(assigns(:user_usergroup))
  end

  test "should show user_usergroup" do
    get :show, id: @user_usergroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_usergroup
    assert_response :success
  end

  test "should update user_usergroup" do
    patch :update, id: @user_usergroup, user_usergroup: { begin_date: @user_usergroup.begin_date, description: @user_usergroup.description, user_id: @user_usergroup.user_id, usergroup_id: @user_usergroup.usergroup_id }
    assert_redirected_to user_usergroup_path(assigns(:user_usergroup))
  end

  test "should destroy user_usergroup" do
    assert_difference('UserUsergroup.count', -1) do
      delete :destroy, id: @user_usergroup
    end

    assert_redirected_to user_usergroups_path
  end
end
