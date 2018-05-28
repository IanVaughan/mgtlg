require_relative  "./text_input/answer"

module TextInput
  extend self

  def answer(string)
    Answer.parse(string)
  end
end
