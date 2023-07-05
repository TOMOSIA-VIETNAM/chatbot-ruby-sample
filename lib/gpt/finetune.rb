module GPT
  class Finetune
    attr_reader :client, :finetunes

    def initialize
      @client = Client.constructor
      @finetunes = []
    end

    def display
      @finetunes = load_all
      finetunes.each do |fine_tune|
        training_file = fine_tune["training_files"][0]
        result_file   = fine_tune["result_files"][0] || {}

        printf <<-EOF
          \n=======================================================================\n
          Fine tuned model: #{fine_tune['fine_tuned_model']}
          Status: #{fine_tune['status'].to_s.upcase}
          Finetune:
            + File tune id: #{fine_tune['id']}
            + Progress: #{fine_tune['hyperparams']['n_epochs']}
            + Model training: #{fine_tune['model']}
          Training file:
            + File id: #{training_file['id']}
            + Filename: #{training_file['filename']}
            + Created at: #{Time.at(training_file['created_at'])}
            + Status: #{training_file['status'].to_s.upcase}
          Result file:
            + File id: #{result_file['id']}
            + Filename: #{result_file['filename']}
            + Created at: #{Time.at(result_file['created_at']) if result_file['created_at']}
            + Status: #{result_file['status'].to_s.upcase}
        EOF
      end

      puts "\n=======================================================================\n"
    end

    def load_all(reload: false)
      return @finetunes = client.finetunes.list["data"] if reload
      return @finetunes unless @finetunes.empty?

      @finetunes = client.finetunes.list["data"]
    end

    def delete_all
      @finetunes = load_all
      finetunes.each do |fine_tune|
        next unless fine_tune['fine_tuned_model']

        delete(fine_tune['fine_tuned_model'])
      end
    end

    def delete(fine_tuned_model)
      client.finetunes.delete(fine_tuned_model:)
    end

    def get(fine_tune_id)
      client.finetunes.retrieve(id: fine_tune_id)
    end

    def cancel(fine_tune_id)
      client.finetunes.cancel(id: fine_tune_id)
    end

    def events(fine_tune_id)
      client.finetunes.events(id: fine_tune_id)
    end
  end
end
