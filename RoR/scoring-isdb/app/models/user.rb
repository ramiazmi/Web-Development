class User < ActiveRecord::Base
  
  validate :init, :if => :new_record?
  # before_create :confirmation_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
         #, :confirmable
         # , :encryptable
         # :registerable,

  public
  def is_admin? # Admin User
    self.user_type.count('A') >= 1
  end
  def is_eval? # Evaluation User
    self.user_type.count('E') >= 1
  end
  def is_app? # Proposal (Applciant) User
    self.user_type.count('U') >= 1
  end
  def can_select? # User can select a proposal
    self.user_type.count('S') >= 1
  end

  def self.users_count(p_user_type)
    User.where("user_type like ?","%#{p_user_type}%").count(:id)
  end


  def user_type_desc
    if self.user_type=='A'
      'Administrator'
    elsif self.user_type=='E'
      'مقيّم'
    else
      'مقدّم مقترح'
    end
      
  end

  def has_proposal(p_grant_id)
    proposal=Proposal.where("user_id=? and grant_id=?",self.id, p_grant_id)
    proposal.present?
  end

  def init
      # if current_user.present? 
      #   if current_user.user_type=='A'
      #     self.user_type  ||= 'E'
      #   end
      # else
        self.user_type  ||= 'U'		
  	  # end
  end 

  def self.search(p_str)
      where("user_type!='A' and user_name||email like ?","%#{p_str}%")
  end
end
