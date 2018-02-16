class ProvincesController < ApplicationController
  before_action :set_province, only: [:show, :edit, :update, :destroy]
  before_action :check_privs

  # GET /provinces
  # GET /provinces.json
  def index
    @provinces = Province.search(params[:search])
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
  end

  # GET /provinces/new
  def new
    @province = Province.new
  end

  # GET /provinces/1/edit
  def edit
  end

  # POST /provinces
  # POST /provinces.json
  def create
    @province = Province.new(province_params)

    respond_to do |format|
      if @province.save
        format.html { redirect_to provinces_path, notice: 'Province was successfully created.' }
        format.json { render :show, status: :created, location: @province }
      else
        format.html { render :new }
        format.json { render json: @province.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provinces/1
  # PATCH/PUT /provinces/1.json
  def update
    respond_to do |format|
      if @province.update(province_params)
        format.html { redirect_to provinces_path, notice: 'Province was successfully updated.' }
        format.json { render :show, status: :ok, location: @province }
      else
        format.html { render :edit }
        format.json { render json: @province.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provinces/1
  # DELETE /provinces/1.json
  def destroy
    @province.destroy
    respond_to do |format|
      format.html { redirect_to provinces_url, notice: 'Province was successfully destroyed.' }
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
    def set_province
      @province = Province.find(params[:id])
    rescue
      redirect_to home_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def province_params
      params.require(:province).permit(:name, :poverty_mapping)
    end
end
