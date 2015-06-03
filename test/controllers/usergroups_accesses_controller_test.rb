require 'test_helper'

class UsergroupsAccessesControllerTest < ActionController::TestCase
  setup do
    @usergroups_access = usergroups_accesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usergroups_accesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usergroups_access" do
    assert_difference('UsergroupsAccess.count') do
      post :create, usergroups_access: { access: @usergroups_access.access, photo_id: @usergroups_access.photo_id, usergroup_id: @usergroups_access.usergroup_id }
    end

    assert_redirected_to usergroups_access_path(assigns(:usergroups_access))
  end

  test "should show usergroups_access" do
    get :show, id: @usergroups_access
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usergroups_access
    assert_response :success
  end

  test "should update usergroups_access" do
    patch :update, id: @usergroups_access, usergroups_access: { access: @usergroups_access.access, photo_id: @usergroups_access.photo_id, usergroup_id: @usergroups_access.usergroup_id }
    assert_redirected_to usergroups_access_path(assigns(:usergroups_access))
  end

  test "should destroy usergroups_access" do
    assert_difference('UsergroupsAccess.count', -1) do
      delete :destroy, id: @usergroups_access
    end

    assert_redirected_to usergroups_accesses_path
  end
end
