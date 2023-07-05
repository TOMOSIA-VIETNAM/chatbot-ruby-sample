# Docs: https://blog.appsignal.com/2023/05/31/how-to-use-sinatra-to-build-a-ruby-application.html

require 'bundler'
Bundler.require

require './services/embeddings/build_chat.rb'

module OpenAi
  class Server < Sinatra::Base
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    # development settings
    configure :development do
      register Sinatra::Reloader
    end

    post '/chat' do
      content_type :json
      chatbot = Services::Embeddings::BuildChat.new(params['text'], max_token: 6_000)
      chatbot.build
      { answers: chatbot.answers, status: 200 }.to_json
    end
  end
end
