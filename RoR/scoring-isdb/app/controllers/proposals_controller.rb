class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy, :complete]
  skip_before_filter :verify_authenticity_token, :only => [:update]
  respond_to :html, :json, :js


  def update_selection 
    active_grant_id=Grant.active_grant_id
    grant=Grant.find(active_grant_id)
    unless active_grant_id==-1
      params["proposal"].keys.each do |id|
        @proposal = Proposal.find(id.to_i)
      end
      Proposal.update(params['proposal'].keys, params['proposal'].values) unless params['proposal'].values==nil
      respond_to do |format|
        if @proposal.save
          grant.update_attribute(:is_selection_done, true)
          format.html { redirect_to reports_path, notice: 'تمت عملية اختيار المقترحات الفائزة بنجاح' }
          format.json { render :show, status: :created, location: @proposal }
        else
          format.html { render :new }
          format.json { render json: @proposal.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to reports_assessments_mark_order_path, alert: 'لا توجد منحة فعالة' }
      end
    end
  end

  # GET /proposals
  # GET /proposals.json
  def index
    pages_no=9
    if current_user.is_eval?
      @proposals = Proposal.search(params[:search], current_user.id, current_user.user_type).paginate(page: params[:page], per_page: pages_no)
    elsif current_user.is_app?
      @proposals = Proposal.search(params[:search], current_user.id, current_user.user_type).paginate(page: params[:page], per_page: pages_no)
    else
      @proposals = Proposal.search(params[:search], current_user.id, current_user.user_type).paginate(page: params[:page], per_page: pages_no)
    end
  end

  def complete
    @proposal.update_attribute(:is_submitted, true)
    # Assessment.close(@proposal.id)
    redirect_to proposals_path, notice: "Proposal was submitted successfully" 
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
    if current_user.user_type=='U' and @proposal.user_id!=current_user.id
      redirect_to home_path
    end
  end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
  end

  # GET /proposals/1/edit
  def edit 
    if @proposal.user_id==current_user.id and @proposal.is_submitted
      redirect_to proposal_path(@proposal)
    elsif @proposal.user_id!=current_user.id
      redirect_to home_path #proposal_path(@proposal)
    end

    @geographic_coverage=GeographicCoverage.new
    @budget=Budget.new
    @fund=Fund.new
  end

  def add_proposal
    grant=Grant.active_grant_id
    if grant != -1
      if current_user.has_proposal(grant)
        grant=-1
      end
    end
    if grant != -1
      @proposal=Proposal.new
      @proposal.grant_id=grant
      @proposal.user_id=current_user.id
      @proposal.is_submitted=false
      @proposal.save! 
      respond_to do |format|
        if @proposal.save
          format.html { redirect_to edit_proposal_path(@proposal.id), notice: 'تم إنشاء مقترح جديد بنجاح' }
          format.json { render :show, status: :ok, location: @proposal }
        else
          format.html { render :edit }
          format.json { render json: @proposal.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to '/', alert: 'عفواً! لا توجد منحة متاحة..' }
      end
    end
  end  

  # POST /proposals
  # POST /proposals.json
  def create
  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    b=1
    g=1
    f=1
    m=1

    j=0  
      if params.has_key?(:geographic_coverage)
        g=0 unless !(params[:geographic_coverage][:locality_id].present?)
      end 
      if params.has_key?(:fund) 
        f=0 unless !(params[:fund][:fund_source_id].present?)
      end
      if params.has_key?(:budget) 
        b=0 unless !(params[:budget][:project_action].present?)   
      end 

      m=b*g*f  
      
      # m=1
      if m==0  
        if f==0
          tot_funds_percent=Fund.where("proposal_id=?",@proposal.id).sum(:percentage)
          percent=fund_params.extract!(:percentage).values.first
          total=tot_funds_percent+percent.to_i
          if total<=100
            @fund=Fund.create(fund_params)  
            @fund.save!
            respond_to do |f|
              if @fund.save
                f.html { redirect_to edit_proposal_path(@proposal.id) }
                # format.json { render :show, status: :ok, location: @proposal }
                f.js
              end 
            end
          else
            respond_to do |f|
              f.html { redirect_to edit_proposal_path(@proposal.id) }
                # format.json { render :show, status: :ok, location: @proposal }
              f.js
            end
          end          
        end #f==0

        if b==0
          @budget=Budget.create(budget_params)
          @budget.save!
          respond_to do |f|
            if @budget.save
              f.html { redirect_to edit_proposal_path(@proposal.id) }
              # format.json { render :show, status: :ok, location: @proposal }
              f.js
            end 
          end
        end

        if g==0
          @GeographicCoverage=GeographicCoverage.create(geographic_coverage_params)
          @GeographicCoverage.save!
          respond_to do |f|
            if @GeographicCoverage.save
              f.html { redirect_to edit_proposal_path(@proposal.id) }
              # f.html { render :edit }
              # format.json { render :show, status: :ok, location: @proposal }
              f.js
            end 
          end
        end
      end
      flash[:alert] = [""]
      if m==1 #1
        if proposal_params.present? #2
          respond_to do |format| #3
            if @proposal.update(proposal_params) #4
              if @proposal.is_submitted #5
                if @proposal.sector_id.blank? or @proposal.sector_id.nil? or
                       @proposal.development_goal_id.blank? or @proposal.development_goal_id.nil? or
                       @proposal.executive_organization.blank? or @proposal.executive_organization.nil? or
                       @proposal.short_term_work_opportunities.blank? or @proposal.short_term_work_opportunities.==0 or
                       @proposal.long_term_work_opportunities.blank? or @proposal.long_term_work_opportunities.==0 or
                       @proposal.project_period.blank? or
                       @proposal.contact_person.blank? or
                       @proposal.contact_phone.blank? or
                       @proposal.contact_email.blank? or 
                       @proposal.funds.size==0 or
                       @proposal.budgets.size==0 or
                       @proposal.geographic_coverages.size==0
                  flash[:alert] = [""]
                  if @proposal.sector_id.blank? 
                    flash[:alert] << "يجب اختيار القطاع"
                  end
                  if @proposal.development_goal_id.blank? or @proposal.development_goal_id.nil?
                   flash[:alert] << "يجب اختيار الهدف التنموي"
                  end
                  if @proposal.project_period.blank? or @proposal.project_period.nil?
                    flash[:alert] << "يجب تحديد مدة تنفيذ المشروع (بالأشهر)"
                  end
                  if @proposal.executive_organization.blank? or @proposal.executive_organization.nil?
                    flash[:alert] << "يجب تحديد المؤسسة جهة التنفيذ المقترحة"
                  end
                  if @proposal.short_term_work_opportunities.blank? or @proposal.short_term_work_opportunities==0
                    flash[:alert] << "يجب تحديد عدد فرص العمل على المدى القصير"
                  end
                  if @proposal.long_term_work_opportunities.blank? or @proposal.long_term_work_opportunities==0
                    flash[:alert] << "يجب تحديد عدد فرص العمل على المدى الطويل"
                  end
                  if @proposal.contact_person.blank? or @proposal.contact_person.nil?
                    flash[:alert] << "يجب تحديد اسم شخص الاتصال"
                  end
                  if @proposal.contact_phone.blank? or @proposal.contact_phone.nil?
                    flash[:alert] << "يجب تحديد رقم الهاتف"
                  end
                  if @proposal.contact_email.blank? or @proposal.contact_email.nil?
                    flash[:alert] << "يجب تحديد البريد الإلكتروني"
                  end
                  if @proposal.budgets.size==0 or @proposal.budgets.sum(:cost)<=0
                    flash[:alert] << "يجب تحديد ميزانية لمكونات/عناصر المشروع أو إدخال قيم صحيحة"
                  end
                  if @proposal.funds.size==0
                    flash[:alert] << "يجب تحديد مصدر/مصادر التمويل"
                  end
                  if @proposal.geographic_coverages.size==0 or @proposal.geographic_coverages.sum(:beneficiaries_number)<=0
                    flash[:alert] << "يجب تحديد التغطية الجغرافية أو إدخال قيم صحيحة"
                  end
                  @proposal.is_submitted=false
                  @proposal.save
                else
                  flash[:alert] = [""]
                end
              if @proposal.is_submitted
                users=User.where("user_type like '%E%'").order(:id)
                users.each do |user|
                  proposalassessmentsummary=ProposalAssessmentSummary.new
                  proposalassessmentsummary.proposal_id=@proposal.id
                  proposalassessmentsummary.user_id=user.id
                  proposalassessmentsummary.save
                end
                sql_1 = %{SELECT distinct 0.0 mark, a.id category_id, b.id criterion_id, c.id proposal_id, d.id user_id
                          FROM categories a, criterions b, proposals c, users d
                         where c.id=}+@proposal.id.to_s+%{ and d.user_type like '%E%' 
                           and b.criterion_type!='E' and a.id=b.category_id order by a.id, b.id}
                @assessments  = Assessment.find_by_sql(sql_1)
                @assessments.each do |assessment|
                  @assessment=Assessment.new
                  @assessment.category_id=assessment.category_id
                  @assessment.criterion_id=assessment.criterion_id
                  @assessment.proposal_id=assessment.proposal_id
                  @assessment.user_id=assessment.user_id
                  @assessment.mark=nil
                  @assessment.save
                end




                proposalassessmentsummary_sys=ProposalAssessmentSummary.new
                proposalassessmentsummary_sys.proposal_id=@proposal.id
                proposalassessmentsummary_sys.user_id=-1
                proposalassessmentsummary_sys.save
                
                sql_2 = %{SELECT distinct 0.0 mark, a.id category_id, b.id criterion_id, c.id proposal_id, -1 user_id
                          FROM categories a, criterions b, proposals c
                         where c.id=}+@proposal.id.to_s+%{ and b.criterion_type='E' and a.id=b.category_id order by a.id, b.id}
                @assessments_sys  = Assessment.find_by_sql(sql_2)
                @assessments_sys.each do |assessment|
                  @assessment_sys=Assessment.new
                  @assessment_sys.category_id=assessment.category_id
                  @assessment_sys.criterion_id=assessment.criterion_id
                  @assessment_sys.proposal_id=assessment.proposal_id
                  @assessment_sys.user_id=assessment.user_id
                  @assessment_sys.mark=nil
                  @assessment_sys.save
                end









                end
              end #5
              flash[:notice] = "تم تسليم المقترح بنجاح !!"
              format.json { render :show, status: :ok, location: @proposal }
              format.js
            else
              format.html { render :edit }
              format.json { render json: @proposal.errors, status: :unprocessable_entity }
            end #4
          end #3
        end #2
      end#1
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  # def destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    rescue
      redirect_to home_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      params.require(:proposal).permit(:project_name, :sector_id, :project_background, :proposal_date, :expected_start_date, :project_period, :project_aim, :target_audience, 
                                       :development_goal_id, :project_actions_description, :stakeholders_choosing_method, :stakeholders_description, :project_approach, 
                                       :technical_methodology, :logical_framework, :supervision, :project_sustainability, :executive_organization, :joint_ventures, :organization_experience,
                                       :contact_person, :contact_phone, :contact_email, :positive_impact, :negative_impact, :short_term_work_opportunities, :long_term_work_opportunities, :project_schedule,
                                       :photos_before_implementation, :project_schedule, :project_photos, :design_readiness_id, 
                                       :user_id, :grant_id, :is_submitted, :is_assessed, :is_selected
                                       )
      # params[:budget][:project_action, :cost_type, :cost, :proposal_id]
    end 
    def geographic_coverage_params
      params.require(:geographic_coverage).permit(:beneficiaries_number, :proposal_id, :locality_id, :classification)
    end
    def budget_params
      params.require(:budget).permit(:project_action, :cost_type, :cost, :proposal_id)
    end
    def fund_params
      params.require(:fund).permit(:percentage, :fund_source_id, :proposal_id)
    end

end
