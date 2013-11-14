require 'test_helper'

class PlatformTypesControllerTest < ActionController::TestCase
  setup do
    @platform_type = platform_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:platform_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create platform_type" do
    assert_difference('PlatformType.count') do
      post :create, platform_type: { title: @platform_type.title }
    end

    assert_redirected_to platform_type_path(assigns(:platform_type))
  end

  test "should show platform_type" do
    get :show, id: @platform_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @platform_type
    assert_response :success
  end

  test "should update platform_type" do
    patch :update, id: @platform_type, platform_type: { title: @platform_type.title }
    assert_redirected_to platform_type_path(assigns(:platform_type))
  end

  test "should destroy platform_type" do
    assert_difference('PlatformType.count', -1) do
      delete :destroy, id: @platform_type
    end

    assert_redirected_to platform_types_path
  end
end
