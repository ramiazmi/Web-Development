class Assessment < ActiveRecord::Base
  has_many :proposals
  belongs_to :criterion
  has_many :assessment_criterion_details, :dependent => :destroy
  has_many :criterion_details, :through => :assessment_criterion_details

  accepts_nested_attributes_for :assessment_criterion_details, 
                                :reject_if => :all_blank

  def self.close(p_proposal_id, p_current_user_id)
    calc_mark=0.0
    l_mark=0.0
    @criterions=Criterion.where("criterion_type='E'")
      @criterions.each do |criterion|
        current_proposal=Proposal.find(p_proposal_id)
        l_weight=CriterionDetail.select('weight').where("criterion_id=?",criterion.id).first.weight
        if criterion.id==1
          l_mark=l_weight*(Proposal.least_budget(current_proposal.sector_id).to_f/current_proposal.proposal_budget)
        #####################
        elsif criterion.id==3
          direct_budget_count=Budget.where("proposal_id=? and cost_type='D'",p_proposal_id).count(:id)
          if direct_budget_count>=5
            l_mark=1
          elsif direct_budget_count==4
            l_mark=2
          elsif direct_budget_count<=3
            l_mark=3
          end
        #####################          
        elsif criterion.id==4
          indirect_budget_percentage=Budget.where("proposal_id=? and cost_type='I'",p_proposal_id).sum(:cost)/current_proposal.proposal_budget
          if indirect_budget_percentage>=0.05
            l_mark=1
          elsif indirect_budget_percentage>=0.03 and indirect_budget_percentage<0.05
            l_mark=2
          elsif indirect_budget_percentage>=0.01 and indirect_budget_percentage<0.03
            l_mark=3
          else
            l_mark=0
          end
        #####################
        elsif criterion.id==6
          provinces_number=Locality.select('distinct localities.id').joins(:geographic_coverages).where("geographic_coverages.proposal_id=?",current_proposal.id).count(:id)
          all_wb=Locality.select('distinct localities.id').joins(:geographic_coverages).where("geographic_coverages.proposal_id=? and locality_category='W'",current_proposal.id).count(:id)
          all_gaza=Locality.select('distinct localities.id').joins(:geographic_coverages).where("geographic_coverages.proposal_id=? and locality_category='G'",current_proposal.id).count(:id)
          national=Locality.select('distinct localities.id').joins(:geographic_coverages).where("geographic_coverages.proposal_id=? and locality_category='N'",current_proposal.id).count(:id)
          
          if provinces_number==1
           l_mark=1
          elsif provinces_number>=2 and provinces_number<=6
            l_mark=2
          elsif (all_wb>0 and all_gaza==0) or (all_wb==0 and all_gaza>0)
            l_mark=3
          elsif (all_wb>0 and all_gaza>0) or (national>0)
            l_mark=4
          else
            l_mark=0
          end
        #####################            
        elsif criterion.id==7
          l_mark=l_weight*(current_proposal.proposal_areas.to_f/Proposal.most_areas)
        #####################        
        elsif criterion.id==9
          geographic_coverages=Locality.joins(:geographic_coverages).where("geographic_coverages.proposal_id=?",current_proposal.id)
          poverty_sum=geographic_coverages.joins(:province).sum(:poverty_mapping)
          poverty_count=geographic_coverages.joins(:province).count
          l_mark=(poverty_sum/poverty_count) unless poverty_count==0              
        #####################
        elsif criterion.id==18
          if current_proposal.development_goal_id.nil?
            l_mark=0
          else
            l_mark=l_weight
          end
        #####################
        elsif criterion.id==20  
          beneficiaries_sum=GeographicCoverage.joins(:locality).where("proposal_id=?",current_proposal.id).sum(:beneficiaries_number)
          population_sum=GeographicCoverage.joins(:locality).where("proposal_id=?",current_proposal.id).sum(:population)
          percent=(beneficiaries_sum.to_f/population_sum) * 100
          
          if percent<21 and percent>=0
            l_mark=2
          elsif percent<41 and percent>=21
            l_mark=4
          elsif percent<61 and percent>=41
            l_mark=6
          elsif percent<81 and percent>=61
            l_mark=8
          elsif percent<=100 and percent>=81
            l_mark=10
          else
            l_mark=0
          end
        #####################
        elsif criterion.id==22
          l_mark=l_weight*(current_proposal.short_term_work_opportunities.to_f/Proposal.most_short_term_work_opportunities)
        #####################        
        elsif criterion.id==23
          l_mark=l_weight*(current_proposal.long_term_work_opportunities.to_f/Proposal.most_long_term_work_opportunities)
        end

        calc_mark=l_mark.round(2)
        current_assessment=Assessment.where("proposal_id=? and criterion_id=? and user_id=?",current_proposal.id, criterion.id, p_current_user_id).first
        current_assessment.update_attribute(:mark, calc_mark)   
    end 
    sum=Assessment.where("proposal_id=? and user_id=?",p_proposal_id, p_current_user_id).sum(:mark)
    @proposal_assessment_summary=ProposalAssessmentSummary.where("proposal_id=? and user_id=?", p_proposal_id, p_current_user_id).first
    @proposal_assessment_summary.update_attribute(:is_assessed, true)
    @proposal_assessment_summary.update_attribute(:total_mark, sum)
  end

end
