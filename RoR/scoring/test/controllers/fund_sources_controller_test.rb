require 'test_helper'

class FundSourcesControllerTest < ActionController::TestCase
  setup do
    @fund_source = fund_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fund_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fund_source" do
    assert_difference('FundSource.count') do
      post :create, fund_source: { description: @fund_source.description, is_active: @fund_source.is_active }
    end

    assert_redirected_to fund_source_path(assigns(:fund_source))
  end

  test "should show fund_source" do
    get :show, id: @fund_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fund_source
    assert_response :success
  end

  test "should update fund_source" do
    patch :update, id: @fund_source, fund_source: { description: @fund_source.description, is_active: @fund_source.is_active }
    assert_redirected_to fund_source_path(assigns(:fund_source))
  end

  test "should destroy fund_source" do
    assert_difference('FundSource.count', -1) do
      delete :destroy, id: @fund_source
    end

    assert_redirected_to fund_sources_path
  end
end
