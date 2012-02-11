require 'test_helper'

class ForumpostsControllerTest < ActionController::TestCase
  setup do
    @forumpost = forumposts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forumposts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forumpost" do
    assert_difference('Forumpost.count') do
      post :create, forumpost: @forumpost.attributes
    end

    assert_redirected_to forumpost_path(assigns(:forumpost))
  end

  test "should show forumpost" do
    get :show, id: @forumpost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @forumpost
    assert_response :success
  end

  test "should update forumpost" do
    put :update, id: @forumpost, forumpost: @forumpost.attributes
    assert_redirected_to forumpost_path(assigns(:forumpost))
  end

  test "should destroy forumpost" do
    assert_difference('Forumpost.count', -1) do
      delete :destroy, id: @forumpost
    end

    assert_redirected_to forumposts_path
  end
end
