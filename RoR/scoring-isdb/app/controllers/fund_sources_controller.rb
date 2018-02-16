class FundSourcesController < ApplicationController
  before_action :set_fund_source, only: [:show, :edit, :update, :destroy]

  # GET /fund_sources
  # GET /fund_sources.json
  def index
    @fund_sources = FundSource.all
  end

  # GET /fund_sources/1
  # GET /fund_sources/1.json
  def show
  end

  # GET /fund_sources/new
  def new
    @fund_source = FundSource.new
  end

  # GET /fund_sources/1/edit
  def edit
  end

  # POST /fund_sources
  # POST /fund_sources.json
  def create
    @fund_source = FundSource.new(fund_source_params)

    respond_to do |format|
      if @fund_source.save
        format.html { redirect_to @fund_source, notice: 'Fund source was successfully created.' }
        format.json { render :show, status: :created, location: @fund_source }
      else
        format.html { render :new }
        format.json { render json: @fund_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fund_sources/1
  # PATCH/PUT /fund_sources/1.json
  def update
    respond_to do |format|
      if @fund_source.update(fund_source_params)
        format.html { redirect_to @fund_source, notice: 'Fund source was successfully updated.' }
        format.json { render :show, status: :ok, location: @fund_source }
      else
        format.html { render :edit }
        format.json { render json: @fund_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fund_sources/1
  # DELETE /fund_sources/1.json
  def destroy
    @fund_source.destroy
    respond_to do |format|
      format.html { redirect_to fund_sources_url, notice: 'Fund source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fund_source
      @fund_source = FundSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fund_source_params
      params.require(:fund_source).permit(:description, :is_active)
    end
end
