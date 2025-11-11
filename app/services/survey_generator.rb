class SurveyGenerator
  def self.generate_for_user(user)
    survey = Survey.create!(user: user)

    # TODO: Implement logic that will generate survey with questions based on answers from previous surveys.
    # For now we'll just use a random sampling of questions from each category.
    Question::CATEGORIES.each do |_, category|
      questions = Question.where(category: category).sample(2)
      questions.each do |question|
        Answer.create!(question_id: question.id, survey: survey)
      end
    end

    survey
  end
end
