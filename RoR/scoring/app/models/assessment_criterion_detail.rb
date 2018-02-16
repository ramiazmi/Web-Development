class AssessmentCriterionDetail < ActiveRecord::Base
	validate :init

	belongs_to :assessment
	belongs_to :criterion_detail

    def init
      self.mark  ||= 2.0
    end  
end
