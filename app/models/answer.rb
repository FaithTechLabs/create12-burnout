class Answer < ApplicationRecord
  belongs_to :survey

  def question
    @question ||= Question.find(question_id)
  end
end
