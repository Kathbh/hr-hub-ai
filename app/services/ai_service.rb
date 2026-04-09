# class AiService
#   def self.ask(prompt)
#     # Create chat session with RubyLLM
#     chat = RubyLLM.chat
#     # Send prompt to model
#     response = chat.ask(prompt)
#     # Return the text only from the response
#     response.content
#   end
# end
class AiService
  def self.ask(prompt)
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "You are an HR Assistant specialized in employment basics across the Americas, EMEA, and APAC regions. Keep all answers short, simple, and easy to understand. Focus only on high‑level information. Avoid legal disclaimers, long explanations, or deep policy details. If a topic varies by country, state, or employer, say 'This can vary depending on local laws and company policy.' Always answer in a friendly, clear tone." },
          { role: "user", content: prompt }
        ]
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
