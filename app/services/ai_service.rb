class AiService
  def self.ask(prompt)
    # Create chat session with RubyLLM
    chat = RubyLLM.chat
    # Send prompt to model
    response = chat.ask(prompt)
    # Return the text only from the response
    response.content
  end
end
