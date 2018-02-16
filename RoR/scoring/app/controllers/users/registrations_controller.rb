class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :check_privs
  
  # GET /resource/index
  # def index
  # supre
  # end

  # GET /resource/sign_up
  def new
    active_grant_id=Grant.active_grant_id
    unless active_grant_id==-1
      grant=Grant.find(active_grant_id)
      if !(grant.evaluation_period?)
        @user=User.new 
      else
        i=-1
      end  
    else
      i=-1        
    end
    if i==-1
      redirect_to home_path, alert: 'لا يمكن إتمام هذه العملية'
    end
  end

  # POST /resource
  def create
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    @user=User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to '/', notice: 'تم تعديل ملف المستخدم بنجاح' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :user_name, :user_type) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:user_name, :user_type, :email, :password, :password_confirmation, :current_password) }
  end

  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                   :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, 
                                   :last_sign_in_ip, :created_at, :updated_at, :user_type, :email_confirmed, :confirm_token, :user_name,
                                   :confirmed_at, :confirmation_sent_at, :confirmation_token)
  end

  private
    def check_privs
      current_user_user_type=current_user.user_type
      if current_user_user_type != params[:id] 
        respond_to do |format|
          format.html { redirect_to home_path, alert: 'لا توجد صلاحيات كافية..' }
        end
      end
    end
  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
