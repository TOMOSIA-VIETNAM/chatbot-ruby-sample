module GPT
  class Chat
    attr_reader :client

    def initialize
      @client = Client.constructor
    end

    def say(text)
      client.chat(
        parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: text}], # Required.
          temperature: 0.7,
          stream: proc do |chunk, _bytesize|
            print chunk.dig("choices", 0, "delta", "content")
          end
        })
    end
  end
end
