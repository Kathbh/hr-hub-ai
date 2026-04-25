module EmployeePortal
  class MessagesController < ApplicationController
    before_action :authenticate_user!

    def create
      Message.create!(
        employee_id: current_user.employee.id,
        recipient_id: params[:recipient_id],
        content: params[:content],
        sender: "employee",
        channel: "direct",
        case_id: nil
      )

      redirect_to employee_path
    end
  end
end
