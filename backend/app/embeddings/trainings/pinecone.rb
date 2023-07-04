require_relative '../../../config.rb'


module App
  module Embeddings
    module Trainings
      class Pinecone
        attr_reader :filename
        DIR_STORAGE = File.expand_path('.', 'publics/data/embeddings')

        def initialize(filename)
          @filename = File.expand_path('.', filename)
          @pinecone = DatabasePinecone::Client.new(ENV['PINECONE_INDEX_NAME'])
        end

        def call
          step_upload_data
        end

        private

        attr_reader :pinecone

        def step_upload_data
          batches = []
          CSV.foreach(filename, headers: true) {|row| batches << row.to_h }

          batches.each_slice(50) do |group|
            vectors = []
            group.each do |record|
              vectors << {
                id: record['id'],
                metadata: {
                  text: record['text'],
                  number_tokens: record['number_tokens']
                },
                values: eval(record['vector'])
              }
            end

            # WARNING: Please create index pinecone before upsert
            # pinecone.create_index
            res = pinecone.upsert(namespace: ENV['PINECONE_INDEX_NAMESPACE'], vectors:)
          end
        end
      end
    end
  end
end

App::Embeddings::Trainings::Pinecone.new('publics/data/embeddings/qlearsupport-normalized-2023-07-05-00-04.csv').call
