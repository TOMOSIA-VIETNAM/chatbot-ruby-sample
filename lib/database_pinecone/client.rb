module DatabasePinecone
  class Client
    attr_reader :client, :index

    def initialize(index)
      Pinecone.configure do |config|
        config.api_key     = ENV.fetch('PINECONE_API_KEY')
        config.environment = ENV.fetch('PINECONE_ENVIRONMENT')
      end

      @client = Pinecone::Client.new
      @index = index
    end

    def upsert(namespace:, vectors:)
      client.index(index).upsert(namespace:, vectors:)
    end

    def query(vector, opts = {})
      client.index(index).query(
        vector:,
        namespace: opts[:namespace],
        top_k: opts[:top_k],
        include_values: opts[:include_values],
        include_metadata: opts[:include_metadata]
      )
    end

    # Model: text-embedding-ada-002
    # Output dimensions: 1536
    # https://platform.openai.com/docs/guides/embeddings/second-generation-models
    def create_index
      client.create_index({
        'metric': 'cosine',
        'name': index,
        'dimension': 1536,
      })
    end
  end
end
