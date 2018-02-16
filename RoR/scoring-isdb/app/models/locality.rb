class Locality < ActiveRecord::Base
  belongs_to :province
  has_many :geographic_coverages 
  #has_many :proposals, :through => :geographic_coverages
  
   	def self.search(p_str)
    	where("locality_name like ?","%#{p_str}%")
 	end
end
