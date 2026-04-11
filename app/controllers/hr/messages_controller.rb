class Hr::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_hr_role

  def create
    puts "🔥 HR::MessagesController#create is running!"

    @case = Case.find(params[:case_id])

    Message.create!(
      case_id: @case.id,
      employee_id: @case.employee.id,
      sender: "HR",
      content: params[:content],
      channel: "hr"
    )

    redirect_to hr_case_path(@case)
  end

  private

  def require_hr_role
    allowed_roles = ["hr_agent", "hr_bt", "payroll", "benefits", "gta"]
    unless current_user.employee.role.in?(allowed_roles)
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
