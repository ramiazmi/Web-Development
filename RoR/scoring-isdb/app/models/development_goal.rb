class DevelopmentGoal < ActiveRecord::Base
	has_many :proposals

  def self.search(p_str)
      where("description like ?","%#{p_str}%")
  end
end
