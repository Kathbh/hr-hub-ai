module Hr
  class AiController < ApplicationController
    before_action :require_hr_role

    def ask
      @agent = current_user
      user_message = params[:content]

      # Save HR message
      Message.create!(
        sender: "hr",
        content: user_message,
        channel: "hr_ai"
      )

      # Call AI
      ai_reply = AiService.ask(user_message)

      # Save AI response
      Message.create!(
        sender: "ai",
        content: ai_reply,
        channel: "hr_ai"
      )

      # Load all messages again
      @messages = Message.where(channel: "hr_ai").order(:created_at)

      # Turbo Stream response
      render turbo_stream: turbo_stream.replace(
        "hr_ai_panel",
        partial: "hr/dashboard/chat"
      )
    end
  end
end
