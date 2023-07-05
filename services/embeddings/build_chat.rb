require_relative '../../config'

module Services
  module Embeddings
    class BuildChat
      attr_reader :question, :pinecone, :context, :raw_content, :records, :max_token, :number_tokens

      def initialize(question_text, max_token: 4000)
        @question      = question_text.gsub(/[[:space:]]+/, ' ').strip
        @max_token     = max_token
        @number_tokens = 0
        @raw_content   = ''
      end

      def build
        @pinecone = DatabasePinecone::Client.new(ENV['PINECONE_INDEX_NAME'])
        @records  = query_pinecone_vectors(question)
        @context  = build_context(records, question)
      end

      def chatting
        chat = GPT::Chat.new
        chat.stream(context)
      end

      def answers
        chat = GPT::Chat.new
        chat.answers(context)
      end

      private

      def query_pinecone_vectors(question)
        vector = GPT::Embedding.create(question)['data'][0]['embedding']
        @pinecone.query(
          vector,
          namespace: ENV['PINECONE_INDEX_NAMESPACE'],
          include_values: true,
          include_metadata: true,
          top_k: 1000,
        )
      end

      def build_context(records, question)
        records['matches'].each do |record|
          @number_tokens += record['metadata']['number_tokens'].to_i
          break if @number_tokens > max_token

          @raw_content += "\n#{record['metadata']['text']}"
        end

        template_prompt(@raw_content, question)
      end

      def template_prompt(context_question, question)
<<~TEMPLATE
以下の内容に基づいて質問に回答いたします。
要望:
回答はフレンドリーで、内容が意味を持つこと。
コンテキストに基づいて回答できない場合は、「申し訳ありません、理解できませんでした」とお伝えし、その後、ユーザーに正確な質問をするように提案します。
回答はMarkdown形式で提供してください。

文脈:
#{context_question}

---

質問: #{question}
TEMPLATE
      end
    end
  end
end
