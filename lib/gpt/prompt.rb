module GPT
  class Prompt
    attr_reader :client, :fine_tuned_model

    def initialize(fine_tuned_model)
      @fine_tuned_model = fine_tuned_model
      @client           = Client.constructor
    end

    def question(text)
      response = client.completions(
        parameters: {
          model: fine_tuned_model,
          prompt: text,
          temperature: 0.5,
          stop: ' END',
          max_tokens: 500,
          stream: proc do |chunk, _bytesize|
            print chunk.dig("choices", 0, "text")
          end
      })
    end
  end
end
