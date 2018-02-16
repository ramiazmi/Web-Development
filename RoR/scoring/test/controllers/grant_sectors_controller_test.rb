require 'test_helper'

class GrantSectorsControllerTest < ActionController::TestCase
  setup do
    @grant_sector = grant_sectors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grant_sectors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grant_sector" do
    assert_difference('GrantSector.count') do
      post :create, grant_sector: { grant_id: @grant_sector.grant_id, percentage: @grant_sector.percentage, sector_id: @grant_sector.sector_id }
    end

    assert_redirected_to grant_sector_path(assigns(:grant_sector))
  end

  test "should show grant_sector" do
    get :show, id: @grant_sector
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grant_sector
    assert_response :success
  end

  test "should update grant_sector" do
    patch :update, id: @grant_sector, grant_sector: { grant_id: @grant_sector.grant_id, percentage: @grant_sector.percentage, sector_id: @grant_sector.sector_id }
    assert_redirected_to grant_sector_path(assigns(:grant_sector))
  end

  test "should destroy grant_sector" do
    assert_difference('GrantSector.count', -1) do
      delete :destroy, id: @grant_sector
    end

    assert_redirected_to grant_sectors_path
  end
end
