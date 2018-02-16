class ProposalAssessmentSummariesController < ApplicationController
  # before_action :set_proposal_assessment_summary, only: [:complete]	

  def reset_assessment
    active_grant_id=Grant.active_grant_id
    grant=Grant.find(active_grant_id)
    proposal_id=params[:proposal_id].to_i
    user_id=params[:user_id].to_i
    unless grant.closed?
      @proposal_assessment_summary=ProposalAssessmentSummary.where("proposal_id=? and user_id=?", proposal_id, user_id).first
      @proposal_assessment_summary.update_attribute(:is_assessed, false)
      @proposal_assessment_summary.update_attribute(:total_mark, nil)
      redirect_to proposals_path, notice: "تمت العملية بنجاح"
    else
      redirect_to assessments_rep_path(proposal_id), alert: "الرجاء إعادة فتح المنحة لإتمام العملية !! "
    end
    # redirect_to assessments_rep_path(proposal_id), notice: "تمت العملية بنجاح"

  end
    
  def complete
    proposal_id=params[:proposal_id].to_i
    current_user_id=current_user.id
    criterions_assessed=Assessment.where("proposal_id=? and user_id=? and mark is null and criterion_id not in (select id from criterions where criterion_type='E' or id in (19))",proposal_id,current_user_id).count(:criterion_id)
    criterion_details_assessed=AssessmentCriterionDetail.where("assessment_criterion_details.assessment_id=(select b.id from assessments b where b.proposal_id=? and b.criterion_id=19 and b.user_id=?)",proposal_id, current_user_id).sum(:mark)
    if criterions_assessed==0 and criterion_details_assessed>0 and current_user.is_eval?

      # # # Calculating Assessments
      # Assessment.close(proposal_id, -1)

      @proposal_assessment_summary=ProposalAssessmentSummary.where("proposal_id=? and user_id=?", proposal_id, current_user_id).first
      mark_sum_1=Assessment.where("proposal_id=? and user_id=?", proposal_id, current_user_id).sum(:mark)
      mark_sum_2=AssessmentCriterionDetail.where("assessment_criterion_details.assessment_id=(select b.id from assessments b where b.proposal_id=? and b.criterion_id=19 and b.user_id=?)",proposal_id, current_user_id).sum(:mark)
      mark_sum=mark_sum_1+mark_sum_2
      @proposal_assessment_summary.update_attribute(:is_assessed, true)
      @proposal_assessment_summary.update_attribute(:total_mark, mark_sum.round(2))
      redirect_to proposals_path, notice: "تم إنهاء تقييم المقترح بنجاح"
    else
      redirect_to edit_all_path(proposal_id), alert: "الرجاء التأكد من تقييم جميع المعايير المطلوبة"
    end
  end

  def index
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal_assessment_summary
      @proposal_assessment_summary = ProposalAssessmentSummary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_assessment_summary_params
      params.require(:proposal_assessment_summary).permit(:is_assessed, :total_mark, :proposal_id, :user_id)
    end
end
