require 'test_helper'

class DevelopmentGoalsControllerTest < ActionController::TestCase
  setup do
    @development_goal = development_goals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:development_goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create development_goal" do
    assert_difference('DevelopmentGoal.count') do
      post :create, development_goal: { description: @development_goal.description, is_active: @development_goal.is_active }
    end

    assert_redirected_to development_goal_path(assigns(:development_goal))
  end

  test "should show development_goal" do
    get :show, id: @development_goal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @development_goal
    assert_response :success
  end

  test "should update development_goal" do
    patch :update, id: @development_goal, development_goal: { description: @development_goal.description, is_active: @development_goal.is_active }
    assert_redirected_to development_goal_path(assigns(:development_goal))
  end

  test "should destroy development_goal" do
    assert_difference('DevelopmentGoal.count', -1) do
      delete :destroy, id: @development_goal
    end

    assert_redirected_to development_goals_path
  end
end
