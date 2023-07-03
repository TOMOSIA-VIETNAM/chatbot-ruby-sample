module GPT
  class Client
    def self.constructor
      OpenAI.configure do |config|
        config.access_token = ENV['OPENAI_API_KEY']
      end
      OpenAI::Client.new
    end
  end
end
