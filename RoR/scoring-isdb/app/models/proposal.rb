class Proposal < ActiveRecord::Base
	belongs_to :user
	belongs_to :grant
    belongs_to :sector
    belongs_to :development_goal
	has_many :geographic_coverages 
	has_many :budgets
    has_many :funds

    # validates :sector_id, presence: true, :if => :is_proposal_submitted?
    # validates :project_period, presence: true, :if=>  :is_proposal_submitted?
    # validates :development_goal_id, presence: true, :if => :is_proposal_submitted?

    def is_proposal_submitted?
      if self.is_submitted.blank? 
        return false
      end
      self.is_submitted
    end

    public
    def completed
        !average_mark.blank?
    end

    def proposal_budget
    	Budget.where("proposal_id=?",self.id).sum(:cost)
    end

    def self.proposals_count(p_active_grant_id)
        Proposal.where("grant_id=?", p_active_grant_id).count(:id)
    end

    def self.submitted_proposals_count(p_active_grant_id)
        Proposal.where("grant_id=? and is_submitted", p_active_grant_id).count(:id)
    end

    def self.assessed_proposals_count(p_active_grant_id)
        # i=ProposalAssessmentSummary.where("proposal_id in (select id from proposals where grant_id=?)", p_active_grant_id).count(:id)
        ProposalAssessmentSummary.where("is_assessed and user_id != -1 and proposal_id in (select id from proposals where grant_id=?)", p_active_grant_id).count(:id)

    end


    def self.least_budget(p_sector_id)
    	@budgets=Budget.select('proposal_id', 'sum(cost) as proposal_budget').group('proposal_id').joins(:proposal).where('proposals.sector_id=? and is_submitted=true', p_sector_id).order('proposal_budget')
    	return @budgets.first.proposal_budget
    end

    def proposal_areas
    	GeographicCoverage.where("proposal_id=?",self.id).count(:locality_id)
    end

    def self.most_areas
    	@areas=GeographicCoverage.select('proposal_id', 'count(locality_id) as proposal_areas').group('proposal_id').joins(:proposal).where('is_submitted=true').order('proposal_areas desc')
    	return @areas.first.proposal_areas
    end

    def self.most_short_term_work_opportunities
    	Proposal.where("is_submitted=true").maximum(:short_term_work_opportunities)
    end
    def self.most_long_term_work_opportunities
    	Proposal.where("is_submitted=true").maximum(:long_term_work_opportunities)
    end

    def self.search(p_str, p_current_user_id, p_current_user_type)
        # find(:all, :conditions => ["","%#{p_str}%"])
    if p_current_user_type=='E'
      @proposals = Proposal.where("is_submitted=true and id in (select distinct b.proposal_id from assessments b where user_id=?) and project_name||executive_organization like ?", p_current_user_id,"%#{p_str}%")
    elsif p_current_user_type=='U'
      where("user_id=? and project_name||executive_organization like ?", p_current_user_id,"%#{p_str}%")
    else
      where("project_name||executive_organization like ?","%#{p_str}%")
    end
    end
end
