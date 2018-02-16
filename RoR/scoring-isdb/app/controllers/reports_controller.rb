class ReportsController < ApplicationController
before_action :check_privs  
  def index
	
  end

  def assessments_rep
    @proposal_id=params[:proposal_id]
    @proposal=Proposal.find(@proposal_id)
    active_grant_id=Grant.active_grant_id
    grant=Grant.find(active_grant_id)
    @sys_assessments=Assessment.joins(:criterion).where("assessments.proposal_id=? and criterions.criterion_type='E'", @proposal_id).order(:category_id,:criterion_id) 

    @eval_users=User.where("user_type like '%E%' and id in (select user_id from proposal_assessment_summaries where proposal_id=? and is_assessed)",@proposal_id)
  end

  def statistics
  	@proposal_sector_t1=Proposal.select("sectors.programme").joins("LEFT JOIN sectors ON sectors.id = proposals.sector_id") #.where("proposals.is_submitted=true and proposals.average_mark is not null")
    @proposal_goal_t1=Proposal.select("development_goals.description").joins("LEFT JOIN development_goals ON development_goals.id = proposals.development_goal_id") #.where("proposals.is_submitted=true and proposals.average_mark is not null")
    @proposal_budget_t1=Budget.select('project_name', 'cost').joins("RIGHT OUTER JOIN proposals on proposals.id=budgets.proposal_id")  #.where("proposals.is_submitted=true and proposals.average_mark is not null")
  
    @proposal_sector_t2=Proposal.select("sectors.programme").joins("LEFT JOIN sectors ON sectors.id = proposals.sector_id").where("proposals.is_submitted=true")
    @proposal_goal_t2=Proposal.select("development_goals.description").joins("LEFT JOIN development_goals ON development_goals.id = proposals.development_goal_id").where("proposals.is_submitted=true")
    @proposal_budget_t2=Budget.select('project_name', 'cost').joins("RIGHT OUTER JOIN proposals on proposals.id=budgets.proposal_id").where("proposals.is_submitted=true")
  end

  def assessments_mark_order
    @assessed_proposals=Proposal.where("grant_id=? and is_submitted=true and average_mark is not null",Grant.active_grant_id).order('average_mark DESC')
  end

  def assessments_province_order
    sql= "select geographic_coverages.proposal_id, proposals.project_name, proposals.executive_organization, localities.province_id, count(0) as province_count
            from proposals, geographic_coverages, localities, provinces
           where proposals.grant_id=1
             and proposals.is_submitted=true
             and proposals.average_mark is not null
             and proposals.id=geographic_coverages.proposal_id
             and localities.id=geographic_coverages.locality_id
             and provinces.id=localities.province_id
           group by geographic_coverages.proposal_id, proposals.project_name, proposals.executive_organization, localities.province_id
           order by province_count desc"
    @proposals=Proposal.find_by_sql(sql)
  end

  private
    def check_privs
      if !(current_user.is_admin?)
        respond_to do |format|
          format.html { redirect_to '/', alert: 'Insufficient Privileges..' } unless current_user.is_admin?
        end
      end
    end

end
