class ChatController < ApplicationController
  def show
    @messages = []
  end

  def create
    user_message = params[:message]

    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "user", content: user_message }
        ]
      }
    )

    ai_reply = response.dig("choices", 0, "message", "content")

    @messages = [
      { role: "user", content: user_message },
      { role: "assistant", content: ai_reply }
    ]

    render :show
  end
end
