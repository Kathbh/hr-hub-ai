# class AiController < ApplicationController
#   skip_before_action :verify_authenticity_token #dont require CSRF token to this controller
#   def chat
#     # Read the prompt from frontend
#     prompt = params[:prompt]
#     #ask AI and send it to the model
#     answer = AiService.ask(prompt)
#     #return JSON so frontend can use
#     render json: { answer: }
#   end
# end
class AiController < ApplicationController
  def create
    prompt = params[:prompt]

    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "user", content: prompt }
        ]
      }
    )

    ai_text = response.dig("choices", 0, "message", "content")

    redirect_to hr_dashboard_path(ai: ai_text)
  end
end
