module EmployeePortal
  class EmployeePortalController < ApplicationController
    before_action :authenticate_user!

    def show
      @employee = current_user.employee
      @cases = @employee.cases.order(created_at: :desc)
      @policies = Policy.all

      # Lista de empleados para el dropdown
      @employees = Employee.all

      # Mensajes rápidos tipo Teams
      @messages = Message.where(
        employee_id: @employee.id,
        case_id: nil,
        channel: "direct"
      ).order(created_at: :asc)
    end
  end
end
