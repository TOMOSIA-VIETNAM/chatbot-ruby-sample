load_path = Dir['/vendor/bundle/ruby/3.2.0/gems/**/lib']
$LOAD_PATH.unshift(*load_path)

require 'openai'
require 'json'
require 'pry'
require 'dotenv'
require 'csv'
require 'tiktoken_ruby'
require 'pinecone'

Dir["lib/**/*.rb"].each { |file| require_relative file }

Dotenv.load
