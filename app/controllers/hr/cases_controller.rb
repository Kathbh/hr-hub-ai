class Hr::CasesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_hr_role

  def index
    @cases = Case.order(created_at: :desc)
  end

  def show
    @case = Case.find(params[:id])
    @employee = @case.employee
    @messages = @case.messages.order(created_at: :asc)

    respond_to do |format|
      #format.turbo_stream { render :show, layout: false }
      format.html { render :show, layout: false }
    end
  end

  private

  def require_hr_role
    allowed_roles = ["hr_agent", "hr_bt", "payroll", "benefits", "gta"]
    unless current_user.employee.role.in?(allowed_roles)
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
