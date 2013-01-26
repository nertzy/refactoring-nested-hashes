QUIZ = {
  question_1: {
    prompt: "What is your name?"
  },

  question_2: {
    prompt: "What is your favorite color?",
    display_proc: ->(color) { "The color is #{color}." }
  },

  question_3: {
    prompt: "What is your favorite integer between 1 and 5?",
    choices: %w[1 2 3 4 5]
  }
}

answers = {}

class Question
  def initialize(question_hash)
    @question_hash = question_hash
  end

  def answer
    if @question_hash[:choices]
      multiple_choice_answer
    else
      simple_answer
    end
  end

  private

  def simple_answer
    print @question_hash[:prompt], " "
    gets.chomp
  end

  def multiple_choice_answer
    choices = @question_hash[:choices]
    answer = nil

    until choices.include?(answer)
      print @question_hash[:prompt], " "
      answer = gets.chomp
      puts "You must pick an answer from #{choices}" unless choices.include?(answer)
    end

    answer
  end
end

QUIZ.each do |name, question_hash|
  question = Question.new(question_hash)
  answers[name] = question.answer
end

display_answers = Hash[
  answers.map do |name, answer|
    if display_proc = QUIZ[name][:display_proc]
      [name, display_proc[answer]]
    else
      [name, answer]
    end
  end
]

p display_answers
