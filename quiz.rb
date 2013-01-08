QUIZ = {
  question_1: {
    prompt: "What is your name?"
  },

  question_2: {
    prompt: "What is your favorite color?"
  },

  question_3: {
    prompt: "What is your favorite integer between 1 and 5?",
    choices: %w[1 2 3 4 5]
  }
}

answers = {}

def simple_answer(question_hash)
  print question_hash[:prompt], " "
  gets.chomp
end

def multiple_choice_answer(question_hash)
  choices = question_hash[:choices]
  answer = nil

  until choices.include?(answer)
    print question_hash[:prompt], " "
    answer = gets.chomp
    puts "You must pick an answer from #{choices}" unless choices.include?(answer)
  end

  answer
end

QUIZ.each do |name, question_hash|
  answer = if question_hash[:choices]
    multiple_choice_answer(question_hash)
  else
    simple_answer(question_hash)
  end

  answers[name] = answer
end

p answers
