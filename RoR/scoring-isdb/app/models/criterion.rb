class Criterion < ActiveRecord::Base
	belongs_to :category
	has_many :criterion_details
	has_many :assessments
end
