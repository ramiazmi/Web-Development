class CriterionDetail < ActiveRecord::Base
	
	has_many :assessment_criterion_details, :dependent => :destroy
    has_many :assessments, :through => :assessment_criterion_details

    accepts_nested_attributes_for :assessment_criterion_details, 
                                :reject_if => :all_blank


  def weight_with_description
    "#{description} ... (#{weight.to_i})"
  end
                          
end
