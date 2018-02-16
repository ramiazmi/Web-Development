class GrantsController < ApplicationController
  before_action :set_grant, only: [:show, :edit, :update, :destroy, :close, :reset_grant]
  before_action :check_privs

  def reset_grant
    @grant.update_attribute(:closed_at, nil)
    # redirect_to grants_path, notice: "تمت العملية بنجاح"
    # redirect_to assessments_rep_path(proposal_id), notice: "تمت العملية بنجاح"
    respond_to do |format|
      if @grant.save
        format.html { redirect_to grants_path, notice: 'تمّ تعديل منحة بنجاح' }
        format.json { render :show, status: :ok, location: @grant }
      else
        format.html { render :edit }
        format.json { render json: @grant.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    grant_id=Grant.active_grant_id
    if grant_id=@grant.id
      assessments_in_progress=ProposalAssessmentSummary.joins(:proposal).where("proposal_assessment_summaries.user_id != -1 and proposals.grant_id=? and (proposal_assessment_summaries.is_assessed is null or proposal_assessment_summaries.is_assessed=false)",grant_id)
      unless !(assessments_in_progress.blank?)
        @proposals=Proposal.where("grant_id=? and is_submitted",@grant.id).order(:id)
        @proposals.each do |proposal|
          # Calculating Assessments
          Assessment.close(proposal.id, -1)
          l_evals_no=ProposalAssessmentSummary.select(:user_id).distinct.where("user_id != -1").count
          l_avg_man_mark=ProposalAssessmentSummary.where("proposal_id=? and user_id != -1",proposal.id).sum(:total_mark)/(l_evals_no)  unless l_evals_no==0 
          puts "l_avg_man_mark  >>  ", l_avg_man_mark
          l_sys_mark=ProposalAssessmentSummary.where("proposal_id=? and user_id = -1",proposal.id).first.total_mark
          puts "l_sys_mark  >>  ", l_sys_mark
          l_avg_mark=l_avg_man_mark+l_sys_mark
          proposal.update_attribute(:average_mark, l_avg_mark.round(2))
        end  
        @grant.update_attribute(:closed_at, Time.now) 
        redirect_to grants_path, notice: "تم إغلاق المنحة والاحتساب النهائي لتقييم المقترحات"
      else
        redirect_to grants_path, alert: "هناك مقترحات قيد التقييم"
      end
    end #check grant_id
  end

  # GET /grants
  # GET /grants.json
  def index
    @grants = Grant.all.order('id desc')
  end

  # GET /grants/1
  # GET /grants/1.json
  def show

  end

  # GET /grants/new
  def new
    @grant = Grant.new
  end

  # GET /grants/1/edit
  def edit
  end

  # POST /grants
  # POST /grants.json
  def create
    if Grant.active_grant_id==-1
      @grant = Grant.new(grant_params)
      respond_to do |format|
        if @grant.save
          grant_id=@grant.id
          sectors=Sector.all.order(:id)
          sectors.each do |sector|
            @grant_sector=GrantSector.new
            @grant_sector.grant_id=grant_id
            @grant_sector.sector_id=sector.id
            @grant_sector.percentage=sector.percentage
            @grant_sector.save
          end  
          format.html { redirect_to @grant, notice: 'تمّ إضافة منحة جديدة بنجاح' }
          format.json { render :show, status: :created, location: @grant }
        else
          format.html { render :new }
          format.json { render json: @grant.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to grants_path, alert: 'توجد منحة فعالة!! .. لا يمكن إضافة منحة جديدة'
    end  
  end

  # PATCH/PUT /grants/1
  # PATCH/PUT /grants/1.json
  def update
    respond_to do |format|
      if @grant.update(grant_params)
        format.html { redirect_to grants_path, notice: 'تمّ تعديل منحة بنجاح' }
        format.json { render :show, status: :ok, location: @grant }
      else
        format.html { render :edit }
        format.json { render json: @grant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grants/1
  # DELETE /grants/1.json
  def destroy
    @grant.destroy
    respond_to do |format|
      format.html { redirect_to grants_url, notice: 'تمّ حذف منحة بنجاح' }
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
    def set_grant
      @grant = Grant.find(params[:id])
    rescue
      @grant = Grant.find(params[:grant_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grant_params
      params.require(:grant).permit(:description, :is_active, :budget, :closing_at, :starting_at, :closed_at, :is_selection_done)
    end

end
