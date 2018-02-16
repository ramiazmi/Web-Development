require 'test_helper'

class CriterionDetailsControllerTest < ActionController::TestCase
  setup do
    @criterion_detail = criterion_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:criterion_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create criterion_detail" do
    assert_difference('CriterionDetail.count') do
      post :create, criterion_detail: { criterion_id: @criterion_detail.criterion_id, description: @criterion_detail.description, is_active: @criterion_detail.is_active, weight: @criterion_detail.weight }
    end

    assert_redirected_to criterion_detail_path(assigns(:criterion_detail))
  end

  test "should show criterion_detail" do
    get :show, id: @criterion_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @criterion_detail
    assert_response :success
  end

  test "should update criterion_detail" do
    patch :update, id: @criterion_detail, criterion_detail: { criterion_id: @criterion_detail.criterion_id, description: @criterion_detail.description, is_active: @criterion_detail.is_active, weight: @criterion_detail.weight }
    assert_redirected_to criterion_detail_path(assigns(:criterion_detail))
  end

  test "should destroy criterion_detail" do
    assert_difference('CriterionDetail.count', -1) do
      delete :destroy, id: @criterion_detail
    end

    assert_redirected_to criterion_details_path
  end
end
