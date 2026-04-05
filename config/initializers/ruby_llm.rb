RubyLLM.configure do |config|
  config.provider = :github
  config.github_api_key = ENV["GITHUB_TOKEN"]
  config.github_model = "gpt-4o-mini"
end
