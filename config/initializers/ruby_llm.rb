RubyLLM.configure do |config|
  config.default_client = :github
  config.clients = {
    github: {
      api_key: ENV["GITHUB_TOKEN"],
      model: "gpt-4o-mini"
    }
  }
end
