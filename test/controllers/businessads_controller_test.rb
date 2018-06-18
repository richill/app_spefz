require 'test_helper'

class BusinessadsControllerTest < ActionController::TestCase
  setup do
    @businessad = businessads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:businessads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create businessad" do
    assert_difference('Businessad.count') do
      post :create, businessad: { category_advert_id: @businessad.category_advert_id, content: @businessad.content, displaytext: @businessad.displaytext, event_id: @businessad.event_id, image: @businessad.image, link: @businessad.link, name: @businessad.name }
    end

    assert_redirected_to businessad_path(assigns(:businessad))
  end

  test "should show businessad" do
    get :show, id: @businessad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @businessad
    assert_response :success
  end

  test "should update businessad" do
    patch :update, id: @businessad, businessad: { category_advert_id: @businessad.category_advert_id, content: @businessad.content, displaytext: @businessad.displaytext, event_id: @businessad.event_id, image: @businessad.image, link: @businessad.link, name: @businessad.name }
    assert_redirected_to businessad_path(assigns(:businessad))
  end

  test "should destroy businessad" do
    assert_difference('Businessad.count', -1) do
      delete :destroy, id: @businessad
    end

    assert_redirected_to businessads_path
  end
end
