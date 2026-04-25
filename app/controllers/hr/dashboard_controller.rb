class Hr::DashboardController < ApplicationController
  before_action :require_hr_role

  def show
    @cases = Case.all
    @policies = Policy.all
    @ai_response = params[:ai]

    # HR employee (Laura)
    @hr_employee = current_user.employee

    # Lista de todos los empleados (para el dropdown)
    @employees = Employee.all

    # Todos los mensajes directos (Teams-like)
    @messages = Message.where(
      case_id: nil,
      channel: "direct"
    ).order(created_at: :asc)

    respond_to do |format|
      format.html
    end
  end
end
