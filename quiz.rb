class Question
  attr_reader :display_proc

  def initialize(prompt, choices = nil, display_proc = nil)
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

QUIZ = {
  question_1: Question.new("What is your name?"),
  question_2: Question.new("What is your favorite color?",
                           nil,
                           ->(color) { "The color is #{color}." }),
  question_3: Question.new("What is your favorite integer between 1 and 5?",
                           %w[1 2 3 4 5])
}

answers = {}

QUIZ.each do |name, question|
  answers[name] = question.answer
end

display_answers = Hash[
  answers.map do |name, answer|
    if display_proc = QUIZ[name].display_proc
      [name, display_proc[answer]]
    else
      [name, answer]
    end
  end
]

p display_answers
