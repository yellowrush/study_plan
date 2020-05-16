class StudyPlansController < ApplicationController
  before_action :require_login

  def index
    @current_study_plan = current_user.study_plans.where("start_date <= ? AND end_date >= ?", Date.today, Date.today).first
    @study_plans = current_user.study_plans.order("start_date DESC")
  end

  def show
    @study_plan = current_user.study_plans.find(params[:id])
  end

  def new
    @study_plan = current_user.study_plans.build(
      start_date: params[:start_date] || Date.today,
      end_date: params[:end_date] || 6.days.from_now.to_date,
    )
    
    @study_plan.build_plans
  end

  def create
    @study_plan = current_user.study_plans.build(study_plan_params)
    
    if @study_plan.save
      redirect_to study_plan_path(@study_plan), notice: "Study Plan Created"
    else
      @errors = @study_plan.errors.full_messages
      render :new
    end
  end

  def edit
    @study_plan = current_user.study_plans.find(params[:id])
  end

  def update
    @study_plan = current_user.study_plans.find(params[:id])
    
    if @study_plan.update_attributes(study_plan_params)
      redirect_to study_plan_path(@study_plan), notice: "Study Plan Updated"
    else
      @errors = @study_plan.errors.full_messages
      render :edit
    end
  end

  def destroy
    @study_plan = current_user.study_plans.find(params[:id])
    @study_plan.destory

    redirect_to study_plans_path, notice: "Study Plan Deleted!"
  end

  private

  def study_plan_params
    params.require(:study_plan).permit(
      :start_date,
      :end_date,
      studies_attributes: [
        :id,
        :date,
        :recipe_id,
      ]
    )
  end
end
