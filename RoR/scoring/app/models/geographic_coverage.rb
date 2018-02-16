class GeographicCoverage < ActiveRecord::Base
	belongs_to :proposal
	belongs_to :locality
end
