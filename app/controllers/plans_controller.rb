class PlansController < ApplicationController
  before_action :require_login

  def index
    @plans = current_user.plans.order(:id)
  end

  def show
    @plan = current_user.plans.find(params[:id])
  end

  def new
    @plan = current_user.plans.build
  end

  def create
    @plan = current_user.plans.build(plan_params)

    if @plan.save
      redirect_to plan_path(@plan), notice: "Plan Created!"
    else
      @errors = @plan.errors.full_messages
      render :new
    end
  end

  def edit
    @plan = current_user.plans.find(params[:id])
  end

  def update
    @plan = current_user.plans.find(params[:id])

    if @plan.update_attributes(plan_params)
      redirect_to plan_path(@plan), notice: "Plan Updated!"
    else
      @errors = @plan.errors.full_messages
      render :edit
    end
  end

  def destroy
    plan = current_user.plans.find(params[:id])
    plan.destroy
    redirect_to plans_path, notice: "Deleted Plan: #{plan.name}"
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :description)
  end
end