require 'test_helper'

class BuyerProfilesControllerTest < ActionController::TestCase
  setup do
    @buyer_profile = buyer_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buyer_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buyer_profile" do
    assert_difference('BuyerProfile.count') do
      post :create, buyer_profile: {  }
    end

    assert_redirected_to buyer_profile_path(assigns(:buyer_profile))
  end

  test "should show buyer_profile" do
    get :show, id: @buyer_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buyer_profile
    assert_response :success
  end

  test "should update buyer_profile" do
    put :update, id: @buyer_profile, buyer_profile: {  }
    assert_redirected_to buyer_profile_path(assigns(:buyer_profile))
  end

  test "should destroy buyer_profile" do
    assert_difference('BuyerProfile.count', -1) do
      delete :destroy, id: @buyer_profile
    end

    assert_redirected_to buyer_profiles_path
  end
end
