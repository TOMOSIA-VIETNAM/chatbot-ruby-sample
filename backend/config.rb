load_path = Dir["/vendor/bundle/ruby/3.2.0/gems/**/lib"]
$LOAD_PATH.unshift(*load_path)

require "openai"
require "json"
require "pry"
require 'dotenv'
require_relative "lib/gpt/client"
require_relative "lib/gpt/document"
require_relative "lib/gpt/finetune"
require_relative "lib/gpt/prompt"
require_relative "lib/gpt/chat"
Dotenv.load
