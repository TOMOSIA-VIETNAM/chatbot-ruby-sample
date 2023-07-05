module GPT
  class Chat
    attr_reader :client

    def initialize
      @client = Client.constructor
    end

    def stream(text, model: 'gpt-3.5-turbo-16k')
      client.chat(
        parameters: {
          model: model, # Required.
          messages: build_default_messages.push({ role: 'user', content: text }), # Required.
          temperature: 0.5,
          stream: proc do |chunk, _bytesize|
            print chunk.dig('choices', 0, 'delta', 'content')
          end
        })
    end

    def answers(text, model: 'gpt-3.5-turbo-16k')
      response = client.chat(
        parameters: {
          model: model, # Required.
          messages: build_default_messages.push({ role: 'user', content: text }), # Required.
          temperature: 0.5,
        })
      response.dig('choices', 0, 'message', 'content')
    end

    private

    def build_default_messages
      [
        { role: "system", content: "私はAIアシスタントです。会社のコンサルタント役を担当します。" },
      ]
    end
  end
end
