require_relative '../../config'
require_relative 'build_chat'

def build_chatbot
  loop do
    print "Nhập câu hỏi (exit để thoát): ".clr_gray

    question_text = gets.chomp.strip
    break if question_text.downcase == "exit" || question_text.downcase == "!!!"

    chatbot = App::Embeddings::BuildChat.new(question_text, max_token: 10_000)
    chatbot.build
    # Answer for question using stream
    chatbot.chatting

    # Answer for question not using stream
    # puts chatbot.answers

    puts "\n\n"
  end
end

build_chatbot
