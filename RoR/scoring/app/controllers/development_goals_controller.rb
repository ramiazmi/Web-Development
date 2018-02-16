class DevelopmentGoalsController < ApplicationController
  before_action :set_development_goal, only: [:show, :edit, :update, :destroy]
  before_action :check_privs
  
  # GET /development_goals
  # GET /development_goals.json
  def index
    @development_goals = DevelopmentGoal.search(params[:search]).order(:id)
  end

  # GET /development_goals/1
  # GET /development_goals/1.json
  def show
  end

  # GET /development_goals/new
  def new
    @development_goal = DevelopmentGoal.new
  end

  # GET /development_goals/1/edit
  def edit
  end

  # POST /development_goals
  # POST /development_goals.json
  def create
    @development_goal = DevelopmentGoal.new(development_goal_params)

    respond_to do |format|
      if @development_goal.save
        format.html { redirect_to @development_goal, notice: 'Development goal was successfully created.' }
        format.json { render :show, status: :created, location: @development_goal }
      else
        format.html { render :new }
        format.json { render json: @development_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /development_goals/1
  # PATCH/PUT /development_goals/1.json
  def update
    respond_to do |format|
      if @development_goal.update(development_goal_params)
        format.html { redirect_to @development_goal, notice: 'Development goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @development_goal }
      else
        format.html { render :edit }
        format.json { render json: @development_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /development_goals/1
  # DELETE /development_goals/1.json
  def destroy
    @development_goal.destroy
    respond_to do |format|
      format.html { redirect_to development_goals_url, notice: 'Development goal was successfully destroyed.' }
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
    def set_development_goal
      @development_goal = DevelopmentGoal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def development_goal_params
      params.require(:development_goal).permit(:description, :is_active)
    end
end
