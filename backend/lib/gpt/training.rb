module GPT
  class Training
    attr_reader :client, :filename, :file_id, :fine_tune_id, :model_training, :suffix

    def initialize(filename, model_training:, suffix:)
      @filename       = filename
      @model_training = model_training
      @suffix         = suffix
      @client         = Client.constructor
    end

    def call
      step_upload_file
      step_training
    end

    private

    def step_upload_file
      response = client.files.upload(parameters: { file: filename, purpose: 'fine-tune' })
      @file_id = response["id"]
      puts "Uploaded !!!\nFile id: #{file_id}"
    end

    def step_training
      response = client.finetunes.create(
        parameters: {
        training_file: file_id,
        model: model_training,
        suffix:
      })
      @fine_tune_id = response["id"]
      puts "File tune id: #{fine_tune_id}"
    rescue StandardError => e
      puts e
      Document.delete(file_id)
    end
  end
end
