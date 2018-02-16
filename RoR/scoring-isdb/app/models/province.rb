class Province < ActiveRecord::Base
has_many :localities
	def self.search(p_str)
    	where("name like ?","%#{p_str}%")
 	end
end
