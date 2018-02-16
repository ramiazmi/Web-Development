class GeographicCoveragesController < ApplicationController
  before_action :set_geographic_coverage, only: [:show, :edit, :update, :destroy]

  # GET /geographic_coverages
  # GET /geographic_coverages.json
  def index
    @geographic_coverages = GeographicCoverage.all
  end

  # GET /geographic_coverages/1
  # GET /geographic_coverages/1.json
  def show
  end

  # GET /geographic_coverages/new
  def new
    @geographic_coverage = GeographicCoverage.new
  end

  # GET /geographic_coverages/1/edit
  def edit
  end

  # POST /geographic_coverages
  # POST /geographic_coverages.json
  def create
    @proposal=Proposal.find(params[:id])
    @geographic_coverage = GeographicCoverage.new(geographic_coverage_params)
    ssssadasd asd as
    respond_to do |format|
      if @geographic_coverage.save
        format.html { redirect_to edit_proposal_path(params[:id]), notice: 'Geographic coverage was successfully created.' }
        format.json { render :show, status: :created, location: @geographic_coverage }
        format.js
      else
        format.html { render :new }
        format.json { render json: @geographic_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geographic_coverages/1
  # PATCH/PUT /geographic_coverages/1.json
  def update
    respond_to do |format|
      if @geographic_coverage.update(geographic_coverage_params)
        format.html { redirect_to @geographic_coverage, notice: 'Geographic coverage was successfully updated.' }
        format.json { render :show, status: :ok, location: @geographic_coverage }
      else
        format.html { render :edit }
        format.json { render json: @geographic_coverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geographic_coverages/1
  # DELETE /geographic_coverages/1.json
  def destroy
    @proposal=Proposal.find(@geographic_coverage.proposal_id)
    @geographic_coverage.destroy
    respond_to do |format|
              format.html { redirect_to edit_proposal_path(@proposal.id) }
              # format.json { render :show, status: :ok, location: @proposal }
              format.js
    end
    # @geographic_coverage.destroy
    # respond_to do |format|
    #   format.html { redirect_to geographic_coverages_url, notice: 'Geographic coverage was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geographic_coverage
      @geographic_coverage = GeographicCoverage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def geographic_coverage_params
      params.require(:geographic_coverage).permit(:beneficiaries_number, :proposal_id, :locality_id)
    end
end
