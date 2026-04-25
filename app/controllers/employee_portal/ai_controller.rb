module EmployeePortal
  class AiController < ApplicationController
    before_action :authenticate_user!

    def ask
      @employee = current_user.employee
      user_message = params[:content]

      # Save employee message
      Message.create!(
        employee: @employee,
        sender: "employee",
        content: user_message,
        channel: "ai"
      )

      # Call AI
      ai_reply = AiService.ask(user_message)

      # Save AI response
      Message.create!(
        employee: @employee,
        sender: "ai",
        content: ai_reply,
        channel: "ai"
      )

      # Fallback → create case
      fallback_phrases = [
        "vary depending",
        "local laws",
        "company policy",
        "contact your hr",
        "i don’t have access",
        "i don't have access",
        "i cannot determine",
        "i’m not sure",
        "i'm not sure",
        "depends on your company"
      ]

      if fallback_phrases.any? { |phrase| ai_reply.downcase.include?(phrase) }
        Case.create!(
          employee: @employee,
          category: "General Inquiry",
          status: :open,
          description: user_message
        )
      end

      # Load all messages again so the chat can re-render
      @messages = Message.where(employee: @employee, channel: "ai").order(:created_at)

      # Re-render the full chat UI inside the turbo-frame
      render turbo_stream: turbo_stream.replace(
        "employee_ai_panel",
        partial: "employee_portal/employee_portal/chat"
      )
    end
  end
end
