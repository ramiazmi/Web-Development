class GrantSectorsController < ApplicationController
  # before_action :set_grant_sector, only: [:show, :edit, :update, :destroy, :gs_edit_all]
  before_action :check_privs

  def gs_edit_all
      @grant_id=Grant.active_grant_id
      @grant_sectors = GrantSector.where("grant_id=?", @grant_id).order(:id)
  rescue
    @grant_sectors = GrantSector.where("1=0")
  end
  def gs_update_all
    @tot_percent=0
    params['grant_sector'].values.each do |rel| 
      @tot_percent=@tot_percent+rel["percentage"].to_i
    end
    if @tot_percent==100  
      params["grant_sector"].keys.each do |id|
        @grant_sector = GrantSector.find(id.to_i)
        GrantSector.update(params['grant_sector'].keys, params['grant_sector'].values)
      end
      respond_to do |format|
        format.html { redirect_to grant_sectors_path, notice: '' }
        format.js
      end
    else
       # redirect_to '/active_grant_sectors/all/gs_edit', alert: 'يجب أن يكون مجموع النسب يساوي ١٠٠٪'
      # format.html { redirect_to grant_sectors_path, notice: '' }
      respond_to do |format|
        puts "HERE HERE HERE"
        @errors = 'يجب أن يكون مجموع النسب يساوي ١٠٠٪'
        format.json { render json: @errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # GET /grant_sectors
  # GET /grant_sectors.json
  def index
    @grant_sectors = GrantSector.all.order(:grant_id, :sector_id)
  end

  # GET /grant_sectors/1
  # GET /grant_sectors/1.json
  def show
  end

  # GET /grant_sectors/new
  def new
    @grant_sector = GrantSector.new
  end

  # GET /grant_sectors/1/edit
  def edit
  end

  # POST /grant_sectors
  # POST /grant_sectors.json
  def create
    @grant_sector = GrantSector.new(grant_sector_params)

    respond_to do |format|
      if @grant_sector.save
        format.html { redirect_to @grant_sector, notice: 'Grant sector was successfully created.' }
        format.json { render :show, status: :created, location: @grant_sector }
      else
        format.html { render :new }
        format.json { render json: @grant_sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grant_sectors/1
  # PATCH/PUT /grant_sectors/1.json
  def update
    respond_to do |format|
      if @grant_sector.update(grant_sector_params)
        format.html { redirect_to @grant_sector, notice: 'Grant sector was successfully updated.' }
        format.json { render :show, status: :ok, location: @grant_sector }
      else
        format.html { render :edit }
        format.json { render json: @grant_sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grant_sectors/1
  # DELETE /grant_sectors/1.json
  def destroy
    @grant_sector.destroy
    respond_to do |format|
      format.html { redirect_to grant_sectors_url, notice: 'Grant sector was successfully destroyed.' }
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
    def set_grant_sector
      @grant_sector = GrantSector.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grant_sector_params
      params.require(:grant_sector).permit(:percentage, :grant_id, :sector_id)
    end
end
