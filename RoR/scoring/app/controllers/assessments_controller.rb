class AssessmentsController < ApplicationController
  before_action :set_assessment, only: [:show, :edit, :update, :destroy, :criteriondetailsassessments, :edit_all, :update_all]
  skip_before_filter :verify_authenticity_token
  before_action :check_privs
  respond_to :html, :json, :js

  # GET /assessments
  # GET /assessments.json
  def index
    @assessments = Assessment.all
  end

  def criteriondetailsassessments
    @assessment = Assessment.where("proposal_id=? and criterion_id=19",params[:proposal_id])
    @assessment_criterion_details = @assessment.assessment_criterion_details
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

    respond_to do |format|
      if @assessment.save
        format.html { redirect_to @assessment, notice: 'Assessment was successfully created.' }
        format.json { render :show, status: :created, location: @assessment }
      else
        format.html { render :new }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html { redirect_to @assessment, notice: 'Assessment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
    @assessment.destroy
    respond_to do |format|
      format.html { redirect_to assessments_url, notice: 'Assessment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # GET /assessments/all/edit
  def edit_all
    proposal_id=params[:proposal_id]
    # @assessments_s1 = Assessment.where("criterion_id in (18) and proposal_id=? and user_id=?", proposal_id, current_user.id).order(:category_id, :criterion_id)    
    # 6,7, removed from s2
    @assessments_s2 = Assessment.where("criterion_id in (8,10) and proposal_id=? and user_id=?", proposal_id, current_user.id).order(:category_id, :criterion_id)    
    @assessments_s3 = Assessment.where("criterion_id in (11,12,13,14,15,16,17,21) and proposal_id=? and user_id=?", proposal_id, current_user.id).order(:category_id, :criterion_id)
    @assessments_s4 = Assessment.where("criterion_id in (2,5)   and proposal_id=? and user_id=?", proposal_id, current_user.id).order(:category_id, :criterion_id)  
    @assessments_s5 = Assessment.where("criterion_id in (17) and proposal_id=? and user_id=?", proposal_id, current_user.id).order(:category_id, :criterion_id)
    @assessments_s6 = Assessment.where("criterion_id in (19) and proposal_id=? and user_id=?", proposal_id, current_user.id).order(:category_id, :criterion_id)
  
    @assessment_criterion_details=AssessmentCriterionDetail.all
  end

  # PUT /assessments/all
  def update_all
    params["assessment"].keys.each do |id|
      @assessment = Assessment.find(id.to_i)
    #   put params['assessment'].values
    #   Assessment.update(params['assessment'].keys, params['assessment'].values)
    end
    Assessment.update(params['assessment'].keys, params['assessment'].values) unless params['assessment'].values==nil
    
    respond_to do |format|
      format.html { redirect_to edit_all_path(@assessment.proposal_id), notice: 'Assessment was successfully updated.'  }
      # format.html { render :edit_all, status: :ok, location: @assessment }
      format.js
    end
  end

  private
    def check_privs
      if !(current_user.is_eval?) or current_user.blank?
        respond_to do |format|
          format.html { redirect_to '/', alert: 'Insufficient Privileges..' } unless current_user.is_eval?
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      if params[:id].present?
        @assessment = Assessment.find(params[:id])
      else
        @assessment = Assessment.where("proposal_id=? and criterion_id=19",params[:proposal_id])
      end


    end

    def user_params(id)
      params.require(:assessment).fetch(id).permit(:mark, :proposal_id, :category_id, :criterion_id, :criterion_detail_id, :assessment_criterion_detail, :criterion_detail_ids => [])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
     def assessment_params
      params.require(:assessment).permit(:mark, :proposal_id, :category_id, :criterion_id, :assessment_criterion_detail, :criterion_detail_ids => [])
     end

     def assessment_criterion_detail_params
      params.require(:assessment_criterion_detail).permit(:mark, :criterion_detail_id, :assessment_id, :criterion_detail_ids => [])
     end
end
