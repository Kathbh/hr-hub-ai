class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    sender_role = current_user.employee.role.in?(["hr_agent", "hr_bt", "payroll", "benefits", "gta"]) ? "hr" : "employee"

    @message = Message.new(
      sender: sender_role,
      employee_id: current_user.employee.id,   # sender_id
      recipient_id: params[:recipient_id],     # recipient_id
      content: params[:content],
      channel: "direct",
      case_id: nil
    )

    if @message.save
      # PRIVACIDAD REAL: solo mensajes entre current_user y recipient
      current_user_id = current_user.employee.id
      other_user_id = params[:recipient_id].to_i

      @messages = Message.where(
        "(employee_id = :current AND recipient_id = :other) OR
        (employee_id = :other AND recipient_id = :current)",
        current: current_user_id,
        other: other_user_id
      ).order(:created_at)

      @employees = Employee.all

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to hr_dashboard_path(recipient_id: params[:recipient_id]) }
      end
    else
      redirect_to hr_dashboard_path, alert: "Message could not be sent."
    end
  end
end
