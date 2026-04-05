RubyLLM.configure do |config|
  config.api_key = ENV["GITHUB_TOKEN"]
  config.model = "gpt-4o-mini"
  config.api_base = "https://models.inference.ai.azure.com"
end
