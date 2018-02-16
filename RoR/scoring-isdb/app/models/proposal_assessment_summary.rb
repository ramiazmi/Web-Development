class ProposalAssessmentSummary < ActiveRecord::Base
	belongs_to :proposal

	def self.is_assessed(p_proposal_id, p_user_id)
		ProposalAssessmentSummary.select(:is_assessed).where("proposal_id=? and user_id=? and user_id != -1", p_proposal_id, p_user_id)
	end
end
