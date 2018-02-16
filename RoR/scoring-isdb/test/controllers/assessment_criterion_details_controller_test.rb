require 'test_helper'

class AssessmentCriterionDetailsControllerTest < ActionController::TestCase
  setup do
    @assessment_criterion_detail = assessment_criterion_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assessment_criterion_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assessment_criterion_detail" do
    assert_difference('AssessmentCriterionDetail.count') do
      post :create, assessment_criterion_detail: { assessment_id: @assessment_criterion_detail.assessment_id, criterion_detail_id: @assessment_criterion_detail.criterion_detail_id, mark: @assessment_criterion_detail.mark }
    end

    assert_redirected_to assessment_criterion_detail_path(assigns(:assessment_criterion_detail))
  end

  test "should show assessment_criterion_detail" do
    get :show, id: @assessment_criterion_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assessment_criterion_detail
    assert_response :success
  end

  test "should update assessment_criterion_detail" do
    patch :update, id: @assessment_criterion_detail, assessment_criterion_detail: { assessment_id: @assessment_criterion_detail.assessment_id, criterion_detail_id: @assessment_criterion_detail.criterion_detail_id, mark: @assessment_criterion_detail.mark }
    assert_redirected_to assessment_criterion_detail_path(assigns(:assessment_criterion_detail))
  end

  test "should destroy assessment_criterion_detail" do
    assert_difference('AssessmentCriterionDetail.count', -1) do
      delete :destroy, id: @assessment_criterion_detail
    end

    assert_redirected_to assessment_criterion_details_path
  end
end
