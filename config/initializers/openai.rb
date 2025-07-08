require 'openai'

OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_API_KEY")
end

# Define el cliente como constante global
OPENAI_CLIENT = OpenAI::Client.new
