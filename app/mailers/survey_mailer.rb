class SurveyMailer < ApplicationMailer
  def survey_notification
    survey = params[:survey]
    @hash_id = survey.hash_id
    mail(to: survey.user.email, subject: "Please complete your survey")
  end

  def survey_complete
    survey = params[:survey]
    # find the survey answer with the lowest answer score 
    # -> use the bible verse from the question
    mail(to: survey.user.email, cc: survey.user.accountability_email, subject: "Thank you")
  end
end
