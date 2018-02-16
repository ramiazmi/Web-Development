class CriterionDetailsController < ApplicationController
  before_action :set_criterion_detail, only: [:show, :edit, :update, :destroy]
  before_action :check_privs
  
  # GET /criterion_details
  # GET /criterion_details.json
  def index
    @criterion = Criterion.find(params[:criterion_id])
    @criterion_details = @criterion.criterion_details.all #CriterionDetail.where("criterion_id=?", params[:criterion_id]) #@criterion.criterion_details.all
  end
  # GET /criterion_details/1
  # GET /criterion_details/1.json
  def show
  end

  # GET /criterion_details/new
  def new
    @criterion = Criterion.find(params[:criterion_id])
    @criterion_detail = CriterionDetail.new
  end

  # GET /criterion_details/1/edit
  def edit
  end

  # POST /criterion_details
  # POST /criterion_details.json
  def create
    @criterion_detail = CriterionDetail.new(criterion_detail_params)

    respond_to do |format|
      if @criterion_detail.save
        format.html { redirect_to criterion_criterion_details_path, notice: 'تم إضافة مقياس بنجاح' }
        format.json { render :show, status: :created, location: @criterion_detail }
      else
        format.html { render :new }
        format.json { render json: @criterion_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criterion_details/1
  # PATCH/PUT /criterion_details/1.json
  #criterion_criterion_details_path
  def update
    respond_to do |format|
      if @criterion_detail.update(criterion_detail_params)
        format.html { redirect_to criterion_criterion_details_path, notice: 'تم تعديل المقياس بنجاح' }
        format.json { render :show, status: :ok, location: @criterion_detail }
      else
        format.html { render :edit }
        format.json { render json: @criterion_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criterion_details/1
  # DELETE /criterion_details/1.json
  def destroy
    @criterion_detail.destroy
    respond_to do |format|
      format.html { redirect_to criterion_criterion_details_path, notice: 'تم حذف المقياس بنجاح' }
      format.json { head :no_content }
    end
  end

  private
    def check_privs
      if !(current_user.is_admin?)
        respond_to do |format|
          format.html { redirect_to '/', alert: 'Insufficient Privileges..' } unless current_user.is_admin?
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_criterion_detail
      #@criterion_detail = CriterionDetail.find(params[:id])
      @criterion = Criterion.find(params[:criterion_id])
      @criterion_detail = CriterionDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criterion_detail_params
      params.require(:criterion_detail).permit(:description, :weight, :is_active, :criterion_id)
    end
end
