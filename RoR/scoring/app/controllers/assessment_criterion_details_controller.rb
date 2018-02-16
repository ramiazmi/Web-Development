class AssessmentCriterionDetailsController < ApplicationController
  before_action :set_assessment_criterion_detail, only: [:show, :edit, :update, :destroy]

  # GET /assessment_criterion_details
  # GET /assessment_criterion_details.json
  def index
    @assessment_criterion_details = AssessmentCriterionDetail.all
  end

  # GET /assessment_criterion_details/1
  # GET /assessment_criterion_details/1.json
  def show
  end

  # GET /assessment_criterion_details/new
  def new
    @assessment_criterion_detail = AssessmentCriterionDetail.new
  end

  # GET /assessment_criterion_details/1/edit
  def edit
  end

  # POST /assessment_criterion_details
  # POST /assessment_criterion_details.json
  def create
    @assessment_criterion_detail = AssessmentCriterionDetail.new(assessment_criterion_detail_params)

    respond_to do |format|
      if @assessment_criterion_detail.save
        format.html { redirect_to @assessment_criterion_detail, notice: 'Assessment criterion detail was successfully created.' }
        format.json { render :show, status: :created, location: @assessment_criterion_detail }
      else
        format.html { render :new }
        format.json { render json: @assessment_criterion_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assessment_criterion_details/1
  # PATCH/PUT /assessment_criterion_details/1.json
  def update
    respond_to do |format|
      if @assessment_criterion_detail.update(assessment_criterion_detail_params)
        format.html { redirect_to @assessment_criterion_detail, notice: 'Assessment criterion detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @assessment_criterion_detail }
      else
        format.html { render :edit }
        format.json { render json: @assessment_criterion_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assessment_criterion_details/1
  # DELETE /assessment_criterion_details/1.json
  def destroy
    @assessment_criterion_detail.destroy
    respond_to do |format|
      format.html { redirect_to assessment_criterion_details_url, notice: 'Assessment criterion detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment_criterion_detail
      @assessment_criterion_detail = AssessmentCriterionDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assessment_criterion_detail_params
      params.require(:assessment_criterion_detail).permit(:mark, :criterion_detail_id, :assessment_id)
    end
end
