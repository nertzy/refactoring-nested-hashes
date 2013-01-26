require "rubygems"
require "active_support/all"

class Quiz < Hash

end

class QuestionHash
  delegate :[], to: :@hash

  def initialize(hash)
    @hash = hash
  end

  def has_choices?
    @hash.has_key?(:choices)
  end
end

QUIZ = Quiz.new.replace( {
  question_1: QuestionHash.new(
    prompt: "What is your name?"
  ),

  question_2: QuestionHash.new(
    prompt: "What is your favorite color?"
  ),

  question_3: QuestionHash.new(
    prompt: "What is your favorite integer between 1 and 5?",
    choices: %w[1 2 3 4 5]
  )
} )

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
  answer = if question_hash.has_choices?
    multiple_choice_answer(question_hash)
  else
    simple_answer(question_hash)
  end

  answers[name] = answer
end

p answers
