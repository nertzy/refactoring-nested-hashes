class Question
  attr_reader :name

  def initialize(name, prompt, choices = nil, display_proc = nil)
    @name = name
    @prompt = prompt
    @choices = choices
    @display_proc = display_proc
  end

  def answer
    if @choices
      multiple_choice_answer
    else
      simple_answer
    end
  end

  def display_answer(answer)
    if @display_proc
      @display_proc[answer]
    else
      answer
    end
  end

  private

  def simple_answer
    print @prompt, " "
    gets.chomp
  end

  def multiple_choice_answer
    answer = nil

    until @choices.include?(answer)
      print @prompt, " "
      answer = gets.chomp
      puts "You must pick an answer from #{@choices}" unless @choices.include?(answer)
    end

    answer
  end
end

QUESTIONS = [
  Question.new(:question_1,
               "What is your name?"),
  Question.new(:question_2,
               "What is your favorite color?",
               nil,
               ->(color) { "The color is #{color}." }),
  Question.new(:question_3,
               "What is your favorite integer between 1 and 5?",
               %w[1 2 3 4 5])
]

answers = {}

QUESTIONS.each do |question|
  answers[question.name] = question.answer
end

display_answers = Hash[
  QUESTIONS.map do |question|
    answer = answers[question.name]
    [question.name, question.display_answer(answer)]
  end
]

p display_answers
