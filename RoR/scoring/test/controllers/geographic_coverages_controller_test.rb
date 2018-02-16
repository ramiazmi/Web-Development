require 'test_helper'

class GeographicCoveragesControllerTest < ActionController::TestCase
  setup do
    @geographic_coverage = geographic_coverages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geographic_coverages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geographic_coverage" do
    assert_difference('GeographicCoverage.count') do
      post :create, geographic_coverage: { beneficiaries_number: @geographic_coverage.beneficiaries_number, locality_id: @geographic_coverage.locality_id, proposal_id: @geographic_coverage.proposal_id }
    end

    assert_redirected_to geographic_coverage_path(assigns(:geographic_coverage))
  end

  test "should show geographic_coverage" do
    get :show, id: @geographic_coverage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geographic_coverage
    assert_response :success
  end

  test "should update geographic_coverage" do
    patch :update, id: @geographic_coverage, geographic_coverage: { beneficiaries_number: @geographic_coverage.beneficiaries_number, locality_id: @geographic_coverage.locality_id, proposal_id: @geographic_coverage.proposal_id }
    assert_redirected_to geographic_coverage_path(assigns(:geographic_coverage))
  end

  test "should destroy geographic_coverage" do
    assert_difference('GeographicCoverage.count', -1) do
      delete :destroy, id: @geographic_coverage
    end

    assert_redirected_to geographic_coverages_path
  end
end
