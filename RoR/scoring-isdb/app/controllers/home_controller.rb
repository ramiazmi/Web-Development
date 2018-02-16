class HomeController < ApplicationController
  def home_index
  	unless current_user.blank?
  		if user_signed_in?	
	  		@proposals_all=Proposal.select(:created_at).all
  			@proposals_eval=ProposalAssessmentSummary.where("user_id=? and is_assessed", current_user.id)
  		end
  	end
  end

  def index
  	
  end
end
