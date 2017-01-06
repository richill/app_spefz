require 'test_helper'

class InviteRequestsControllerTest < ActionController::TestCase
  setup do
    @invite_request = invite_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invite_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invite_request" do
    assert_difference('InviteRequest.count') do
      post :create, invite_request: { event_id: @invite_request.event_id, inviter_id: @invite_request.inviter_id, social_id: @invite_request.social_id, status: @invite_request.status, user_id: @invite_request.user_id }
    end

    assert_redirected_to invite_request_path(assigns(:invite_request))
  end

  test "should show invite_request" do
    get :show, id: @invite_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invite_request
    assert_response :success
  end

  test "should update invite_request" do
    patch :update, id: @invite_request, invite_request: { event_id: @invite_request.event_id, inviter_id: @invite_request.inviter_id, social_id: @invite_request.social_id, status: @invite_request.status, user_id: @invite_request.user_id }
    assert_redirected_to invite_request_path(assigns(:invite_request))
  end

  test "should destroy invite_request" do
    assert_difference('InviteRequest.count', -1) do
      delete :destroy, id: @invite_request
    end

    assert_redirected_to invite_requests_path
  end
end
