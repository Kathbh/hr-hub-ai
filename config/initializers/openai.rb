OpenAI.configure do |config|
  config.access_token = ENV["OPENAI_API_KEY"]
end

# client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

# client.chat(
#   parameters: {
#     model: "gpt-4o-mini",
#     messages: [
#       { role: "user", content: "Hello from Kat!" }
#     ]
#   }
# )
