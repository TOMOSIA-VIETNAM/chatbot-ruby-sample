module GPT
  class Document
    attr_reader :client, :documents

    def initialize
      @client = Client.constructor
      @documents = []
    end

    def display
      @documents = load_all(reload: true)
      documents.each do |doc|
        printf <<-EOF
          \n=======================================================================\n
          ID: #{doc["id"]}
          Filename: #{doc["filename"]}
          Purpose: #{doc["purpose"]}
          Status: #{doc["status"].to_s.upcase}
          Created at: #{doc["created_at"]}
        EOF
      end

      puts "\n=======================================================================\n"
    end

    def load_all(reload: false)
      return @files = client.files.list["data"] if reload
      return @files unless @files.empty?

      @files = client.files.list["data"]
    end

    def delete_all
      @files = load_all
      files.each do |file|
        next unless file['id']

        delete(file['id'])
      end
    end

    def delete(file_id)
      client.files.delete(id: file_id)
    end

    def read(file_id)
      client.files.content(id: file_id)
    end
  end
end
