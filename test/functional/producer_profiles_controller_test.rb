require 'test_helper'

class ProducerProfilesControllerTest < ActionController::TestCase
  setup do
    @producer_profile = producer_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:producer_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create producer_profile" do
    assert_difference('ProducerProfile.count') do
      post :create, producer_profile: {  }
    end

    assert_redirected_to producer_profile_path(assigns(:producer_profile))
  end

  test "should show producer_profile" do
    get :show, id: @producer_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @producer_profile
    assert_response :success
  end

  test "should update producer_profile" do
    put :update, id: @producer_profile, producer_profile: {  }
    assert_redirected_to producer_profile_path(assigns(:producer_profile))
  end

  test "should destroy producer_profile" do
    assert_difference('ProducerProfile.count', -1) do
      delete :destroy, id: @producer_profile
    end

    assert_redirected_to producer_profiles_path
  end
end
