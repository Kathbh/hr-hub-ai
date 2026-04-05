RubyLLM.configure do |config|
  config.default_model = "gpt-4o-mini"
  config.github_api_key = ENV["GITHUB_TOKEN"]
end
