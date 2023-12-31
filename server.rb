# Docs: https://blog.appsignal.com/2023/05/31/how-to-use-sinatra-to-build-a-ruby-application.html

require 'bundler'
require './services/embeddings/build_chat.rb'
Bundler.require

# require 'sinatra/custom_logger'
# require 'logger'
module OpenAi
  class Server < Sinatra::Base
    set :bind, '0.0.0.0'

    configure do
      register Sinatra::CrossOrigin

      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'

      file = File.new("#{root}/log/#{environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file

      enable :cross_origin
    end

    configure :development do
      register Sinatra::Reloader
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    get '/' do
      content_type :json

      { bot: 'Hello', status: 200 }.to_json
    end

    post '/chat' do
      content_type :json

      chatbot = Services::Embeddings::BuildChat.new(params['prompt'], max_token: 12_000)
      chatbot.build
      { bot: chatbot.answers, status: 200 }.to_json
    end

    options "*" do
      response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
      response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
      response.headers["Access-Control-Allow-Origin"] = "*"
      200
    end
  end
end
