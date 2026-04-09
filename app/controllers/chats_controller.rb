# class ChatsController < ApplicationController
#   SYSTEM_PROMPT = "You are an HR Assistant specialized in employment basics across the Americas, EMEA, and APAC regions. Keep all answers short, simple, and easy to understand. Focus only on high‑level information. Avoid legal disclaimers, long explanations, or deep policy details. If a topic varies by country, state, or employer, say “This can vary depending on local laws and company policy.” Always answer in a friendly, clear tone."

#   def show
#     @messages = []
#   end

#   def create
#     user_message = params[:message]

#     client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

#     response = client.chat(
#       parameters: {
#         model: "gpt-4o-mini",
#         messages: [
#           { role: "system", content: SYSTEM_PROMPT },
#           { role: "user", content: user_message }
#         ]
#       }
#     )

#     ai_reply = response.dig("choices", 0, "message", "content")

#     @messages = [
#       { role: "user", content: user_message },
#       { role: "assistant", content: ai_reply }
#     ]

#     render :show
#   end
# end
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

    redirect_to employee_path
  end
end
