class Grant < ActiveRecord::Base
	has_many :proposals

  validates_presence_of :description, :message => "الرجاء تعبئة حقل وصف المنحة"
  validates_presence_of :budget, :message => "الرجاء تعبئة حقل ميزانية المنحة"
  validates_presence_of :closing_at, :message => "الرجاء تعبئة حقل تاريخ انتهاء تقديم الطلبات"
  validates_presence_of :starting_at, :message => "الرجاء تعبئة حقل تاريخ بدء تقديم الطلبات"

  public
    def self.active_grant_id
       # grant_id=Grant.where("is_active=true and closed_at is null").last.id
       grant_id=Grant.where("is_active=true").last.id
       return grant_id
    rescue
       return -1
    end
    def is_selection_done?
      self.is_selection_done
    end

  # protected
    def closed?
      !closed_at.blank?
    end

    def proposal_period?
      Date.current>=starting_at and Date.current<=closing_at  
    end

    def evaluation_period?
      closing_at<Date.current and closed_at.blank?
    end
end
