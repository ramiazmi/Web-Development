class Sector < ActiveRecord::Base
	has_many :proposals

  def self.search(p_str)
      where("programme like ?","%#{p_str}%")
  end
end
