QUIZ = {
  question_1: {
    prompt: "What is your name?"
  },

  question_2: {
    prompt: "What is your favorite color?"
  }
}

answers = {}

QUIZ.each do |name, question_hash|
  print question_hash[:prompt], " "
  answers[name] = gets.chomp
end

p answers
