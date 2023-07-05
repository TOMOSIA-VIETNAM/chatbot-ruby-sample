require_relative '../../../config.rb'

module Services
  module Embeddings
    module Csv
      class Normalize
        attr_reader :filename
        DIR_STORAGE = File.expand_path('.', 'public/data/embeddings')

        def initialize(filename)
          @filename = File.expand_path('.', filename)
        end

        def call
          step_normalize_csv
        end

        private

        def step_normalize_csv
          dest_filename = "#{DIR_STORAGE}/#{File.basename(filename, '.csv')}-normalized-#{Time.now.strftime('%Y-%m-%d-%H-%M')}.csv"
          CSV.open(dest_filename, "wb") do |csv|
            csv << ['id', 'number_tokens', 'text', 'vector']
            CSV.foreach(filename, headers: true).with_index(1) do |row, line|
              text = "#{row['prompt']}\n#{row['completion']}"
              csv << [line, count_tokenizer(text), text, convert_vector_embedding(text)]
            end
          end
        end

        def count_tokenizer(text)
          @enc ||= Tiktoken.get_encoding("cl100k_base") # text-embedding-ada-002
          @enc.encode(text).size
        end

        def convert_vector_embedding(text)
          res = GPT::Embedding.create(text)
          res['data'][0]['embedding']
        end

      end
    end
  end
end

App::Embeddings::Csv::Normalize.new('public/data/originals/qlearsupport.csv').call
