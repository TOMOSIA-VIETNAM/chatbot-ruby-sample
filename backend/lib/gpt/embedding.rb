module GPT
  class Embedding
    def self.create(input, model='text-embedding-ada-002')
      client = Client.constructor
      client.embeddings(parameters: { model:, input: })
    end
  end
end
