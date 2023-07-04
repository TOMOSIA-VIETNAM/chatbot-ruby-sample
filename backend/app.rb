require_relative 'config'

### Start Training ###
# training = GPT::Training.new('data/less-qlearsupport_prepared.jsonl', model_training: 'davinci', suffix: 'qlear-support')
# training.call

### Check Document ###
# document = GPT::Document.new
# document.display

### Check Filetune ###
# finetune = GPT::Finetune.new
# finetune.display
# puts finetune.get('ft-Mba0nuyL4kbHXftJ7cmzrTDk')

### Start Prompt ###
prompt = GPT::Prompt.new("davinci:ft-hinodeopenaiproject:qlear-support-2023-07-03-10-29-17")
puts "==========================="
puts "Xin chào! Tôi có thể giúp gì cho bạn?"
puts "===========================\n"
print "Nhập câu hỏi: "

loop do
  question = gets.chomp
  break if question.downcase == "exit"

  print "\n> Trả lời: "
  prompt.question("#{question}")

  print "\n\nNhập câu hỏi (nhập exit để thoát): "
end

# puts "Xin cảm ơn!!!"

### Test Chat ###
# chat = GPT::Chat.new

# puts "Xin chào! Tôi có thể giúp gì cho bạn?"
# puts "===========================\n"
# print "Nhập câu hỏi: "
# loop do
#   text = gets.chomp
#   break if text.downcase == "exit"

#   print "\n> Trả lời: "
#   chat.say(text)

#   print "\n\nNhập exit để thoát: "
# end

# puts "Xin cảm ơn!!!"
