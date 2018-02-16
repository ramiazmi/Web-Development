require 'test_helper'

class ProposalsControllerTest < ActionController::TestCase
  setup do
    @proposal = proposals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposal" do
    assert_difference('Proposal.count') do
      post :create, proposal: { contact_email: @proposal.contact_email, contact_person: @proposal.contact_person, contact_phone: @proposal.contact_phone, design_readiness_id: @proposal.design_readiness_id, development_goal_id: @proposal.development_goal_id, executive_organization: @proposal.executive_organization, expected_start_date: @proposal.expected_start_date, joint_ventures: @proposal.joint_ventures, logical_framework: @proposal.logical_framework, long_term_work_opportunities: @proposal.long_term_work_opportunities, negative_impact: @proposal.negative_impact, organization_experience: @proposal.organization_experience, photos_before_implementation: @proposal.photos_before_implementation, positive_impact: @proposal.positive_impact, project_actions_description: @proposal.project_actions_description, project_aim: @proposal.project_aim, project_approach: @proposal.project_approach, project_background: @proposal.project_background, project_name: @proposal.project_name, project_period: @proposal.project_period, project_photos: @proposal.project_photos, project_schedule: @proposal.project_schedule, project_schedule: @proposal.project_schedule, project_sustainability: @proposal.project_sustainability, proposal_date: @proposal.proposal_date, sector_id: @proposal.sector_id, short_term_work_opportunities: @proposal.short_term_work_opportunities, stakeholders_choosing_method: @proposal.stakeholders_choosing_method, stakeholders_description: @proposal.stakeholders_description, supervision: @proposal.supervision, target_audience: @proposal.target_audience, technical_methodology: @proposal.technical_methodology, user_id: @proposal.user_id }
    end

    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test "should show proposal" do
    get :show, id: @proposal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proposal
    assert_response :success
  end

  test "should update proposal" do
    patch :update, id: @proposal, proposal: { contact_email: @proposal.contact_email, contact_person: @proposal.contact_person, contact_phone: @proposal.contact_phone, design_readiness_id: @proposal.design_readiness_id, development_goal_id: @proposal.development_goal_id, executive_organization: @proposal.executive_organization, expected_start_date: @proposal.expected_start_date, joint_ventures: @proposal.joint_ventures, logical_framework: @proposal.logical_framework, long_term_work_opportunities: @proposal.long_term_work_opportunities, negative_impact: @proposal.negative_impact, organization_experience: @proposal.organization_experience, photos_before_implementation: @proposal.photos_before_implementation, positive_impact: @proposal.positive_impact, project_actions_description: @proposal.project_actions_description, project_aim: @proposal.project_aim, project_approach: @proposal.project_approach, project_background: @proposal.project_background, project_name: @proposal.project_name, project_period: @proposal.project_period, project_photos: @proposal.project_photos, project_schedule: @proposal.project_schedule, project_schedule: @proposal.project_schedule, project_sustainability: @proposal.project_sustainability, proposal_date: @proposal.proposal_date, sector_id: @proposal.sector_id, short_term_work_opportunities: @proposal.short_term_work_opportunities, stakeholders_choosing_method: @proposal.stakeholders_choosing_method, stakeholders_description: @proposal.stakeholders_description, supervision: @proposal.supervision, target_audience: @proposal.target_audience, technical_methodology: @proposal.technical_methodology, user_id: @proposal.user_id }
    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test "should destroy proposal" do
    assert_difference('Proposal.count', -1) do
      delete :destroy, id: @proposal
    end

    assert_redirected_to proposals_path
  end
end
