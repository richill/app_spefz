require 'test_helper'

class ExternalattendinglistsControllerTest < ActionController::TestCase
  setup do
    @externalattendinglist = externalattendinglists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:externalattendinglists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create externalattendinglist" do
    assert_difference('Externalattendinglist.count') do
      post :create, externalattendinglist: { event_id: @externalattendinglist.event_id, user_id: @externalattendinglist.user_id }
    end

    assert_redirected_to externalattendinglist_path(assigns(:externalattendinglist))
  end

  test "should show externalattendinglist" do
    get :show, id: @externalattendinglist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @externalattendinglist
    assert_response :success
  end

  test "should update externalattendinglist" do
    patch :update, id: @externalattendinglist, externalattendinglist: { event_id: @externalattendinglist.event_id, user_id: @externalattendinglist.user_id }
    assert_redirected_to externalattendinglist_path(assigns(:externalattendinglist))
  end

  test "should destroy externalattendinglist" do
    assert_difference('Externalattendinglist.count', -1) do
      delete :destroy, id: @externalattendinglist
    end

    assert_redirected_to externalattendinglists_path
  end
end
