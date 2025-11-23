class SurveyMailer < ApplicationMailer
  def survey_notification
    survey = params[:survey]
    @hash_id = survey.hash_id
    mail(to: survey.user.email, subject: "Please complete your survey")
  end

  def survey_complete
    # find the survey answer with the lowest answer score 
    survey = params[:survey]
    lowest_question_id = survey.answers.order(:answer).first.question_id
    @verse = Question.where(id: lowest_question_id).first.bible_verse
    # -> use the bible verse from the question
    mail(to: survey.user.email, cc: survey.user.accountability_email, subject: "Thank you")
  end
end
