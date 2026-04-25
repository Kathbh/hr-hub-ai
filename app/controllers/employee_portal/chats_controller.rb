module EmployeePortal
  class ChatsController < ApplicationController
    before_action :authenticate_user!

    def show
      @employee = current_user.employee
      @messages = @employee.messages.order(created_at: :asc)
    end

    def create
      @employee = current_user.employee
      user_message = params[:content]

      # Save employee message
      Message.create!(
        employee: @employee,
        sender: "employee",
        content: user_message,
        channel: "chat"
      )

      # Call your AiService
      ai_reply = AiService.ask(user_message)

      # Save AI response
      Message.create!(
        employee: @employee,
        sender: "ai",
        content: ai_reply,
        channel: "chat"
      )

      # Detect if AI could not answer
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
          status: :open,  #updated
          description: user_message
        )
      end

      redirect_to employee_path
    end
  end
end
