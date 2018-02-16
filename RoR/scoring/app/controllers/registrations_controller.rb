# registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:admin_edit, :admin_show, :update]
  skip_before_filter :require_no_authentication, only: [:admin_new, :create, :admin_edit, :update]
  before_action :check_privs
  
  def admin_index
    @users=User.search(params[:search]).order(:id)
  end

  def admin_new
    @user=User.new 
  end

  def create
    @user=User.create(user_params)
    @user.user_type='E'
    @user.save!
    redirect_to admin_users_path, notice: 'تم إضافة مستخدم تقييم جديد بنجاح'
  end

  def admin_show
  end

  def admin_edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'تم تعديل ملف المستخدم بنجاح' }
        format.json { render :admin_show, status: :ok, location: @user }
      else
        format.html { render :admin_edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def check_privs
      if !(current_user.is_admin?)
        respond_to do |format|
          format.html { redirect_to '/', alert: 'Insufficient Privileges..' } unless current_user.uis_admin?
        end
      end
  rescue
    redirect_to '/'
  end

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                   :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, 
                                   :last_sign_in_ip, :created_at, :updated_at, :user_type, :email_confirmed, :confirm_token, :user_name,
                                   :confirmed_at, :confirmation_sent_at, :confirmation_token)
  end
end




